interface ZIF_ZSCOL_PROD_ORD01
  public .


  types:
    AUFNR type C length 000012 .
  types:
    MATNR type C length 000040 .
  types:
    WERKS_D type C length 000004 .
  types:
    CHARG_D type C length 000010 .
  types:
    EBELN type C length 000010 .
  types:
    begin of ZSPP_SEARCH,
      AUFNR type AUFNR,
      MATNR type MATNR,
      MFGPLNT type WERKS_D,
      DATE type DATS,
      ST_DATE type DATS,
      EN_DATE type DATS,
      CHARG type CHARG_D,
      EBELN type EBELN,
      SHPPLNT type WERKS_D,
    end of ZSPP_SEARCH .
  types:
    RALDB_SIGN type C length 000001 .
  types:
    RALDB_OPTI type C length 000002 .
  types:
    begin of WERKS_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type WERKS_D,
      HIGH type WERKS_D,
    end of WERKS_RAN .
  types:
    ZTTWERKS_RAN                   type standard table of WERKS_RAN                      with non-unique default key .
  types:
    begin of MATNR_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type MATNR,
      HIGH type MATNR,
    end of MATNR_RAN .
  types:
    ZTTMATNR_RAN                   type standard table of MATNR_RAN                      with non-unique default key .
  types:
    BKGRP type C length 000003 .
  types:
    begin of ZBKGRP_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type BKGRP,
      HIGH type BKGRP,
    end of ZBKGRP_RAN .
  types:
    ZTTBKGRP_RAN                   type standard table of ZBKGRP_RAN                     with non-unique default key .
  types:
    begin of ZDELDATE_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type DATS,
      HIGH type DATS,
    end of ZDELDATE_RAN .
  types:
    ZTTDELDATE_RAN                 type standard table of ZDELDATE_RAN                   with non-unique default key .
  types:
    ZPOSTATUS type C length 000025 .
  types:
    begin of ZSTATUS_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type ZPOSTATUS,
      HIGH type ZPOSTATUS,
    end of ZSTATUS_RAN .
  types:
    ZTTSTATUS_RAN                  type standard table of ZSTATUS_RAN                    with non-unique default key .
  types:
    begin of ZEBELN_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type EBELN,
      HIGH type EBELN,
    end of ZEBELN_RAN .
  types:
    ZTTEBELN_RAN                   type standard table of ZEBELN_RAN                     with non-unique default key .
  types:
    begin of ZPODOCSTAT_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type DATS,
      HIGH type DATS,
    end of ZPODOCSTAT_RAN .
  types:
    ZTTPODOCSTAT_RAN               type standard table of ZPODOCSTAT_RAN                 with non-unique default key .
  types:
    ZCOMMCODE type C length 000002 .
  types:
    begin of ZPOCOMMCODE_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type ZCOMMCODE,
      HIGH type ZCOMMCODE,
    end of ZPOCOMMCODE_RAN .
  types:
    ZTTPOCOMMCODE_RAN              type standard table of ZPOCOMMCODE_RAN                with non-unique default key .
  types:
    ZSTATUSCODE type C length 000002 .
  types:
    begin of ZPOSTATCODE_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type ZSTATUSCODE,
      HIGH type ZSTATUSCODE,
    end of ZPOSTATCODE_RAN .
  types:
    ZTTPOSTATCODE_RAN              type standard table of ZPOSTATCODE_RAN                with non-unique default key .
  types:
    ZGAPS_FLT type P length 6  decimals 000000 .
  types:
    begin of ZPOGAP_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type ZGAPS_FLT,
      HIGH type ZGAPS_FLT,
    end of ZPOGAP_RAN .
  types:
    ZTTPOGAP_RAN                   type standard table of ZPOGAP_RAN                     with non-unique default key .
  types:
    ZPOCOMMIT type C length 000010 .
  types:
    begin of ZPOCOMMIT_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type ZPOCOMMIT,
      HIGH type ZPOCOMMIT,
    end of ZPOCOMMIT_RAN .
  types:
    ZTTPOCOMMIT_RAN                type standard table of ZPOCOMMIT_RAN                  with non-unique default key .
  types:
    ZEBELN_ASN type C length 000010 .
  types:
    begin of ZASNNO_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type ZEBELN_ASN,
      HIGH type ZEBELN_ASN,
    end of ZASNNO_RAN .
  types:
    ZTTASNNO_RAN                   type standard table of ZASNNO_RAN                     with non-unique default key .
  types:
    CHAR15 type C length 000015 .
  types:
    begin of ZASNSTATUS_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type CHAR15,
      HIGH type CHAR15,
    end of ZASNSTATUS_RAN .
  types:
    ZTTASNSTATUS_RAN               type standard table of ZASNSTATUS_RAN                 with non-unique default key .
  types:
    begin of ZEBELP_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type EBELN,
      HIGH type EBELN,
    end of ZEBELP_RAN .
  types:
    ZTTEBELP_RAN                   type standard table of ZEBELP_RAN                     with non-unique default key .
  types:
    LIFNR type C length 000010 .
  types:
    begin of ZSLIFNR_RAN,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type LIFNR,
      HIGH type LIFNR,
    end of ZSLIFNR_RAN .
  types:
    ZTTLIFNR_RAN                   type standard table of ZSLIFNR_RAN                    with non-unique default key .
  types:
    begin of ZSSP_PAST_DUE,
      SIGN type RALDB_SIGN,
      OPTION type RALDB_OPTI,
      LOW type DATS,
      HIGH type DATS,
    end of ZSSP_PAST_DUE .
  types:
    ZTTPAST_DUE                    type standard table of ZSSP_PAST_DUE                  with non-unique default key .
  types:
    begin of ZSPP_PO_SELECT,
      LOCATION type ZTTWERKS_RAN,
      PRODUCT type ZTTMATNR_RAN,
      PURGROUP type ZTTBKGRP_RAN,
      DELDATE type ZTTDELDATE_RAN,
      STATUS type ZTTSTATUS_RAN,
      PURDOCNO type ZTTEBELN_RAN,
      PODOCSTAT type ZTTPODOCSTAT_RAN,
      POCOMMCODE type ZTTPOCOMMCODE_RAN,
      POSTATCODE type ZTTPOSTATCODE_RAN,
      POGAP type ZTTPOGAP_RAN,
      POCOMMIT type ZTTPOCOMMIT_RAN,
      ASNNO type ZTTASNNO_RAN,
      ASNSTATUS type ZTTASNSTATUS_RAN,
      PURDOCLINENO type ZTTEBELP_RAN,
      LIFNR type ZTTLIFNR_RAN,
      EKGRP type ZTTBKGRP_RAN,
      PAST_DUE type ZTTPAST_DUE,
    end of ZSPP_PO_SELECT .
  types:
    FLAG type C length 000001 .
  types:
    CHAR10 type C length 000010 .
  types:
    ZBSTMG type P length 7  decimals 000003 .
  types:
    EBELP type N length 000005 .
  types:
    TEXT40 type C length 000040 .
  types:
    VORNR type C length 000004 .
  types:
    AUFART type C length 000004 .
  types:
    begin of ZSPP_PRODORD_DUELIST,
      AUFNR type AUFNR,
      MATNR type MATNR,
      WERKS type WERKS_D,
      SHPPLNT type WERKS_D,
      TOT_QTY type ZBSTMG,
      BASE_END_DT type DATS,
      EBELN type EBELN,
      EBELP type EBELP,
      CHARG type CHARG_D,
      ZZSH_WERKS1 type WERKS_D,
      ZZSH_WERKS2 type WERKS_D,
      OPER_TXT type TEXT40,
      OPER type VORNR,
      AUART type AUFART,
    end of ZSPP_PRODORD_DUELIST .
  types:
    __ZSPP_PRODORD_DUELIST         type standard table of ZSPP_PRODORD_DUELIST           with non-unique default key .
  types:
    ETENR type N length 000004 .
  types:
    LGORT_D type C length 000004 .
  types:
    EKGRP type C length 000003 .
  types:
    PSTYP type C length 000001 .
  types:
    NAME1 type C length 000030 .
  types:
    EKNAM type C length 000018 .
  types:
    ZBUYER_EMAIL type C length 000030 .
  types:
    ZBUYER_PHONE type C length 000014 .
  types:
    MFRPN type C length 000040 .
  types:
    ZTEXT_DESC type C length 000040 .
  types:
    ZMANUFACTURER type C length 000060 .
  types:
    REVLV type C length 000002 .
  types:
    ZCE_FLAG type C length 000001 .
  types:
    ZCP_FLAG type C length 000001 .
  types:
    ZFAIR_REQUESTED type C length 000003 .
  types:
    ZSSTHT type C length 000005 .
  types:
    VBELN type C length 000010 .
  types:
    BSTME type C length 000003 .
  types:
    ZSUGGESTIONS type C length 000040 .
  types:
    ZUNIT_PRICE type C length 000017 .
  types:
    ZSUP_CONF_PRICE type P length 6  decimals 000002 .
  types:
    ZEXTENDED_PRICE type P length 6  decimals 000002 .
  types:
    ZLEAD_TIME type P length 2  decimals 000000 .
  types:
    WAERS type C length 000005 .
  types:
    ZFAIRSUB type C length 000001 .
  types:
    ZFAIR_STATUS type C length 000015 .
  types:
    ZFAIR_STATUS_BY type C length 000008 .
  types:
    KONNR type C length 000010 .
  types:
    KTPNR type N length 000005 .
  types:
    ETENS type N length 000004 .
  types:
    ZVISUAL_PO type C length 000020 .
  types:
    LICHN type C length 000015 .
  types:
    ZAGILE_REV type C length 000010 .
  types:
    ZPTEXT_D type C length 000020 .
  types:
    MEINS type C length 000003 .
  types:
    ZSUP_COMMENTS type C length 000241 .
  types:
    TEXT100 type C length 000100 .
  types:
    begin of ZSPP_PO_DUELIST,
      PURDOCNO type EBELN,
      PURDOCLINENO type EBELP,
      POSCHLINENO type ETENR,
      PLANT type WERKS_D,
      STORAGE_LOCATION type LGORT_D,
      PUR_GROUP type EKGRP,
      ITEM_CATEGORY type PSTYP,
      SUPPLIER_ID type LIFNR,
      SUPPLIER_NAME type NAME1,
      PO_CREATION_DT type DATS,
      BUYER type EKNAM,
      BUYER_EMAIL type ZBUYER_EMAIL,
      BUYER_PHONE type ZBUYER_PHONE,
      MATERIALNO type MATNR,
      MPN type MFRPN,
      TEXT_DESCRIPTION type ZTEXT_DESC,
      MANUFACTURER type ZMANUFACTURER,
      REV_LEVEL type REVLV,
      STATUS type ZPOSTATUS,
      QTY type ZBSTMG,
      OPENQTY type ZBSTMG,
      ASN_QTY type ZBSTMG,
      SUPP_COMMIT_OTD type DATS,
      SUPP_COMMIT type DATS,
      CE_FLAG type ZCE_FLAG,
      CP_FLAG type ZCP_FLAG,
      FAIR_REQUESTED type ZFAIR_REQUESTED,
      CRITICAL_SHORTAGE type ZSSTHT,
      ASN_INB_DELIVERY type VBELN,
      CONFQTY type ZBSTMG,
      UOM type BSTME,
      DELDATE type DATS,
      CONF_DELDATE type DATS,
      STATUS_CODE type ZSTATUSCODE,
      COMM_CODE type ZCOMMCODE,
      NEED_DATE type DATS,
      DATE_OF_LAST_COMMIT type DATS,
      DATE_OF_LAST_MRP_CHANGE type DATS,
      GAPS type ZGAPS_FLT,
      SUGGESTIONS type ZSUGGESTIONS,
      UNIT_PRICE type ZUNIT_PRICE,
      SUP_CONF_PRICE type ZSUP_CONF_PRICE,
      EXTEND_PRICE type ZEXTENDED_PRICE,
      LEAD_TIME type ZLEAD_TIME,
      CURRENCY type WAERS,
      FAIR_SUBMITTED type ZFAIRSUB,
      FAIR_STATUS type ZFAIR_STATUS,
      FAIR_STATUS_DATE type DATS,
      FAIR_STATUS_BY type ZFAIR_STATUS_BY,
      CONTRACT_NO type KONNR,
      CONTRACT_ITEM type KTPNR,
      ETENS type ETENS,
      IHREZ type ZVISUAL_PO,
      LICHA type LICHN,
      AGILE_REV type ZAGILE_REV,
      ITEM_CAT_TXT type ZPTEXT_D,
      BUOM type MEINS,
      SUP_COMMENTS type ZSUP_COMMENTS,
      MIMETYPE type TEXT100,
    end of ZSPP_PO_DUELIST .
  types:
    __ZSPP_PO_DUELIST              type standard table of ZSPP_PO_DUELIST                with non-unique default key .
  types:
    EETEN type N length 000004 .
  types:
    ZBDMNG type P length 7  decimals 000003 .
  types:
    CHAR200 type C length 000200 .
  types:
    begin of ZSPP_PO_UPLOAD,
      PURDOCNO type EBELN,
      PURDOCLINENO type EBELP,
      POSCHLINENO type EETEN,
      MATERIALNO type MATNR,
      QTY type ZBDMNG,
      OPENQTY type ZBDMNG,
      CONFQTY type ZBDMNG,
      UOM type MEINS,
      DELDATE type DATS,
      CONFDATE type DATS,
      COMMENTS type CHAR200,
      STATUS type CHAR15,
    end of ZSPP_PO_UPLOAD .
  types:
    __ZSPP_PO_UPLOAD               type standard table of ZSPP_PO_UPLOAD                 with non-unique default key .
endinterface.
