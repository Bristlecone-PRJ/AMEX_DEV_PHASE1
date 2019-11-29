class ZCL_ZOD_COLLABLITE_OPE_DPC_01 definition
  public
  inheriting from ZCL_ZOD_COLLABLITE_OPE_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM
    redefinition .
protected section.

  methods OPENPOSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZOD_COLLABLITE_OPE_DPC_01 IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION.

    data: ls_parameter type /iwbep/s_mgw_name_value_pair,
          lv_ebeln     type ebeln,
          lv_ebelp     type ebelp,
          ls_entity    type zcl_zod_collablite_ope_mpc=>ts_msgreturn.

    types: begin of lty_sel_data,
             ebeln type ebeln,
             ebelp type ebelp,
           end of lty_sel_data.

    data : ls_filter     type zssp_filter,
           lv_role       type zrole,
           ls_text       type scx_t100key,
           lv_conf_qty   type zconf_qty,
           lv_msg_type   type i,
           lv_error_flag type c,
           lv_msg_txt    type string.

    data: lt_po_hdr         type standard table of zspp_po_hdr,
          lt_po_item        type standard table of zspp_po_item,
          lt_po_item_scode  type standard table of zspp_po_item,
          ls_po_item        type                   zspp_po_item,
          lt_po_sched       type standard table of zspp_po_sched,
          lt_po_sched_copy  type standard table of zspp_po_sched,
          ls_po_sched       type zspp_po_sched,
          lt_return         type table of bapiret2,
          ls_return         type bapiret2,
          lt_po_text        type standard table of zspp_po_text,
          ls_zspp_po_select type zspp_po_select.

    data: lt_sel_data type table of lty_sel_data,
          ls_sel_data type lty_sel_data.

    data: ls_zebeln_ran type zebeln_ran,
          lt_zebeln_ran type zttebeln_ran.

    data: lt_ebeln type table of ebeln,
          ls_ebeln type ebeln.

    clear: ls_ebeln, ls_zebeln_ran, ls_sel_data, ls_zspp_po_select,
           ls_filter.
    refresh : lt_ebeln[], lt_zebeln_ran[], lt_po_hdr[],
              lt_po_item[], lt_po_sched[], lt_po_text[], lt_return[].

    if it_parameter is not initial.
* Read Function import parameter value
      read table it_parameter into ls_parameter with key name = 'Purdocno'.
      if sy-subrc = 0.
        ls_ebeln = ls_parameter-value.
        append ls_ebeln to lt_ebeln.

        ls_sel_data-ebeln = ls_parameter-value.

        ls_zebeln_ran-sign   = 'I'.
        ls_zebeln_ran-option = 'EQ'.
        ls_zebeln_ran-low    = ls_parameter-value.
        append ls_zebeln_ran to lt_zebeln_ran.
      endif.

      read table it_parameter into ls_parameter with key name = 'Purdoclineno'.
      if sy-subrc = 0.
        ls_sel_data-ebelp = ls_parameter-value.
      endif.
    endif.
*
*        ls_po_item-purdocno = ls_wklist-purdocno.
*        ls_po_item-purdoclineno =  ls_wklist-purdoclineno.
*        ls_po_item-status_code =  ls_wklist-status_code.
*        ls_po_item-comm_code =  ls_wklist-comm_code.
*
*        APPEND ls_po_item TO it_po_item_scode.
*        CLEAR: ls_po_item, ls_wklist.

    if not ls_sel_data is initial.
      append ls_sel_data to lt_sel_data.
      clear  ls_sel_data.
    endif.

    call function 'ZZCOLLAB_ROLE_FILTER'
      importing
        es_filter = ls_filter.

    sort lt_zebeln_ran by low.
    delete adjacent duplicates from lt_zebeln_ran comparing low.

    ls_zspp_po_select-purdocno = lt_zebeln_ran[].

    check not lt_zebeln_ran[] is initial.

    case iv_action_name.
      when 'massConfirmation'.

        call function 'ZZCOLLAB_OPENPO_CONFIRMATION'
          exporting
            i_operation = 'PODETAIL'
            i_interface = '1'
            i_po_select = ls_zspp_po_select
            i_userid    = sy-uname
            i_sp_filter = ls_filter
          importing
            e_role      = lv_role
          tables
            t_po_hdr    = lt_po_hdr
            t_po_item   = lt_po_item
            t_po_sched  = lt_po_sched
            t_po_text   = lt_po_text
            t_return    = lt_return.

        delete lt_return[] where type ne 'E'.

        if lt_return is not initial.
          me->mo_context->get_message_container( )->add_messages_from_bapi(
            exporting
              it_bapi_messages          = lt_return
          ).

          raise exception type /iwbep/cx_mgw_busi_exception
            exporting
              message_container = me->mo_context->get_message_container( ).

        else.

          sort lt_sel_data by ebeln ebelp.
          loop at lt_po_item assigning field-symbol(<fs_po_item>).
            read table lt_sel_data into ls_sel_data with key ebeln = <fs_po_item>-purdocno
                                                             ebelp = <fs_po_item>-purdoclineno.
            if sy-subrc ne 0.
              clear <fs_po_item>-purdocno.
            endif.
          endloop.
          delete lt_po_item where purdocno is initial.

          loop at lt_po_sched assigning field-symbol(<fs_po_sched>).
            read table lt_sel_data into ls_sel_data with key ebeln = <fs_po_sched>-purdocno
                                                             ebelp = <fs_po_sched>-purdoclineno.
            if sy-subrc ne 0.
              clear <fs_po_sched>-purdocno.
            endif.
          endloop.
          delete lt_po_sched where purdocno is initial.

          lt_po_sched_copy[] = lt_po_sched[].
          sort lt_po_sched by purdocno purdoclineno.
          delete adjacent duplicates from lt_po_sched comparing purdocno purdoclineno.
          loop at lt_po_sched assigning <fs_po_sched>.

            loop at lt_po_sched_copy into ls_po_sched
                                     where purdocno = <fs_po_sched>-purdocno
                                     and purdoclineno = <fs_po_sched>-purdoclineno.
              lv_conf_qty =  lv_conf_qty +   ls_po_sched-confqty.
            endloop.
            <fs_po_sched>-status = 'Added'.
            <fs_po_sched>-confqty =  ( <fs_po_sched>-qty - lv_conf_qty ).

            clear : lv_conf_qty, ls_po_sched.
          endloop.

*NOTE: Here the Create Confirmation creates that additional confirmation with the balance qty required to
*      do a full confirmation of any PO Line Item

**Check for Supplier Commit Date
          clear lv_error_flag.
          loop at lt_po_item into ls_po_item.
            if ls_po_item-supp_commit_otd lt sy-datum.
              concatenate 'Supplier Commit Date should not be in past'
                          ls_po_item-purdocno ls_po_item-purdoclineno
                          into lv_msg_txt separated by space.

              clear : ls_text.
              ls_text-msgid = 'ZSD'.
              ls_text-msgno = 032.
              ls_text-attr1 = lv_msg_txt.

              raise exception type /iwbep/cx_mgw_tech_exception
                exporting
                  textid = ls_text.
              exit.

              lv_error_flag = 'X'.
            endif.
          endloop.

          call function 'ZZCOLLAB_OPENPO_CONFIRMATION'
            exporting
              i_operation = 'MASS_CONF'
              i_interface = '1'
              i_po_select = ls_zspp_po_select
              i_userid    = sy-uname
              i_sp_filter = ls_filter
            tables
              t_po_hdr    = lt_po_hdr
              t_po_item   = lt_po_item
              t_po_sched  = lt_po_sched
              t_po_text   = lt_po_text
              t_return    = lt_return.

          delete lt_return[] where type ne 'E'.

          if lt_return is not initial.
            me->mo_context->get_message_container( )->add_messages_from_bapi(
              exporting
                it_bapi_messages          = lt_return
            ).

            raise exception type /iwbep/cx_mgw_busi_exception
              exporting
                message_container = me->mo_context->get_message_container( ).

          endif.

        endif.

*          IF sy-subrc = 0.
**TYPE
**CODE
**MESSAGE
**MESSAGE_V1
**MESSAGE_V2
*
        ls_entity-type   = 'S'.
        ls_entity-message = 'PO Mass Confirmatiom Successfully Happened'.

* Call method copy_data_to_ref and export entity set data
        copy_data_to_ref( exporting is_data = ls_entity
                changing cr_data = er_data ).

      when 'updatePoStatusCode'.

        call function 'ZZCOLLAB_OPENPO_CONFIRMATION'
          exporting
            i_operation = 'PODETAIL'
            i_interface = '1'
            i_po_select = ls_zspp_po_select
            i_userid    = sy-uname
            i_sp_filter = ls_filter
          importing
            e_role      = lv_role
          tables
            t_po_hdr    = lt_po_hdr
            t_po_item   = lt_po_item
            t_po_sched  = lt_po_sched
            t_return    = lt_return.

        delete lt_return[] where type ne 'E'.
        if lt_return is not initial.
          me->mo_context->get_message_container( )->add_messages_from_bapi(
            exporting
              it_bapi_messages          = lt_return
          ).

          raise exception type /iwbep/cx_mgw_busi_exception
            exporting
              message_container = me->mo_context->get_message_container( ).

        else.

** Populate Status code and Communication code for updation.
*          loop at lt_po_item assigning <fs_po_item>.
*            read table lt_po_item_scode into ls_po_item with key purdocno = <fs_po_item>-purdocno
*                                                                 purdoclineno = <fs_po_item>-purdoclineno.
*            if sy-subrc = 0.
*              <fs_po_item>-comm_code = ls_po_item-comm_code.
*              <fs_po_item>-status_code = ls_po_item-status_code.
*            endif.
*          endloop.

          call function 'ZZCOLLAB_OPENPO_CONFIRMATION'
            exporting
              i_operation = 'UPD_STATUS'
              i_interface = '1'
              i_po_select = ls_zspp_po_select
              i_userid    = sy-uname
              i_sp_filter = ls_filter
            importing
              e_role      = lv_role
            tables
              t_po_hdr    = lt_po_hdr
              t_po_item   = lt_po_item
              t_po_sched  = lt_po_sched
              t_return    = lt_return.

          delete lt_return[] where type ne 'E'.
          if lt_return is not initial.
            me->mo_context->get_message_container( )->add_messages_from_bapi(
              exporting
                it_bapi_messages          = lt_return
            ).

            raise exception type /iwbep/cx_mgw_busi_exception
              exporting
                message_container = me->mo_context->get_message_container( ).

          endif.
        endif.

* Call method copy_data_to_ref and export entity set data
        copy_data_to_ref( exporting is_data = ls_entity
                changing cr_data = er_data ).

      when others.

    endcase.

  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_STREAM.

    data:
      lt_keys    type /iwbep/t_mgw_tech_pairs,
      ls_key     type /iwbep/s_mgw_tech_pair,
      lv_ebeln   type ebeln,
      lv_xstring type xstring,
      ls_stream  type ty_s_media_resource.

    clear : lv_ebeln, lv_xstring.

    lt_keys = io_tech_request_context->get_keys( ).

*    read table lt_keys with key name = 'EBELN' into ls_key.
    read table lt_keys with key name = 'PURDOCNO' into ls_key.
    lv_ebeln = ls_key-value.

    if not lv_ebeln is initial.
      call function 'ZZCOLLAB_CONVERT_PO_PDF'
        exporting
          iv_ebeln  = lv_ebeln
        importing
          ev_string = lv_xstring.

      data : ls_lheader type ihttpnvp.
      ls_lheader-name = 'Content-Disposition'.
*      ls_lheader-value = 'outline; filename="OpenPO.pdf";'.
      concatenate 'outline; filename="' lv_ebeln '.pdf";' into ls_lheader-value.
      condense ls_lheader-value.
      set_header( is_header = ls_lheader ).

      ls_stream-value = lv_xstring.
      ls_stream-mime_type = 'application/pdf'.

      copy_data_to_ref( exporting is_data = ls_stream
                        changing  cr_data = er_stream ).

    endif.
  endmethod.


  method OPENPOSET_GET_ENTITYSET.

************************************************************************
* Purpose          : Open PO Confirmation Fiori application
* Project          : ZOD_COLLABLITE_OPENPO_CONF
* Business Analyst :
* Developed By     : Dhiraj Khambe
* Start Date       : 06/05/2019
*----------------------------------------------------------------------*
* Change History:                                                      *
* Transport   Date        Author      Description                      *
* =========== ========== ============ =================================*
*                                                                      *
*----------------------------------------------------------------------*

    data: it_duelist        type table of zspp_po_duelist,
          ls_zspp_po_select type zspp_po_select.

    data : ls_filter type zssp_filter,
           ls_text   type scx_t100key,
           lt_return type table of bapiret2,
           ls_return type bapiret2.

    refresh : it_duelist[], lt_return[], et_entityset[].
    clear : ls_zspp_po_select, ls_filter, ls_text, ls_return.

* Map Odata Filter option with collblite WD Selection screen
    call function 'ZZCOLLAB_MAP_SELECTOPTIONS'
      exporting
        it_filter_select_options = it_filter_select_options
        it_key_tab               = it_key_tab
      importing
        es_po_select             = ls_zspp_po_select.

* If role is buyer check if the user is assigned to purchasing group.
* If not assigned then atleast one selection restriction is mandatory
    call function 'ZZCOLLAB_ROLE_FILTER'
      importing
        es_filter = ls_filter.

    if not ls_filter is initial.
      if ls_filter-role = 'BUYER'.
* If user is having Buyer Role then considered corresponding Purchasing Group
        call function 'ZZCOLLAB_OPENPO_CONFIRMATION'
          exporting
            i_operation = 'GET_BUYER'
            i_interface = '1'
            i_po_select = ls_zspp_po_select
            i_userid    = sy-uname
            i_sp_filter = ls_filter
          importing
            e_po_select = ls_zspp_po_select.

* If selection option values not provided at all generate an error
        if ls_zspp_po_select is initial.

          ls_text-msgid = 'ZSD'.
          ls_text-msgno = 032.
          ls_text-attr1 = text-e02.

          raise exception type /iwbep/cx_mgw_tech_exception
            exporting
              textid = ls_text.
          exit.
        endif.
      endif.

* Get PO details and process
      call function 'ZZCOLLAB_OPENPO_CONFIRMATION'
        exporting
          i_operation = 'DUELIST'
          i_interface = '1'
          i_po_select = ls_zspp_po_select
          i_userid    = sy-uname
          i_sp_filter = ls_filter
        tables
          t_duelist   = it_duelist
          t_return    = lt_return.

      delete lt_return[] where type ne 'E'.

      if lt_return is not initial.
        me->mo_context->get_message_container( )->add_messages_from_bapi(
          exporting
            it_bapi_messages          = lt_return
        ).

        raise exception type /iwbep/cx_mgw_busi_exception
          exporting
            message_container = me->mo_context->get_message_container( ).

      else.
* Update ET_ENTITYSET with it_duelist
        et_entityset[] = it_duelist[].
      endif.

    else.
      ls_text-msgid = 'ZSD'.
      ls_text-msgno = 032.
      ls_text-attr1 = text-e01.

      raise exception type /iwbep/cx_mgw_tech_exception
        exporting
          textid = ls_text.
      exit.
    endif.
  endmethod.
ENDCLASS.
