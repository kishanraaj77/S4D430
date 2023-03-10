*&---------------------------------------------------------------------*
*& Report s4d430_asso_s1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT s4d430_table_func_s1.

TYPES: BEGIN OF ty_s_customer,
         id         TYPE Scustom-id,
         name       TYPE scustom-name,
         city       TYPE scustom-city,
         country    TYPE scustom-country,
       END OF ty_s_customer.

TYPES ty_t_customers TYPE STANDARD TABLE OF ty_s_customer
                         WITH NON-UNIQUE KEY id.

DATA gt_customers TYPE ty_t_customers.

* ALV Processing

DATA go_salv TYPE REF TO cl_salv_table.
DATA gx_excp TYPE REF TO cx_salv_error.

* Selection Screen

PARAMETERS pa_nam TYPE s_custname DEFAULT 'Schwarz' LOWER CASE.

* Check db feature

DATA gt_feature_set TYPE cl_abap_dbfeatures=>features_set_t.

START-OF-SELECTION.

* Optional: Check if table functions can be used on this DB
**************************************************************
INSERT cl_abap_dbfeatures=>amdp_table_function
       INTO TABLE gt_feature_set.

IF cl_abap_dbfeatures=>use_features( gt_feature_set )
   = abap_false.
 MESSAGE e030(S4D430).
ENDIF.

* Alternative with VALUE expression (Rel. 7.40)

*IF cl_abap_dbfeatures=>use_features(
*              VALUE #( ( cl_abap_dbfeatures=>amdp_table_function ) )
*         ) = abap_false.
* MESSAGE e030(S4D430).
*ENDIF.



* Data Retrieval
*************************************************************

  SELECT
    FROM s4d430_table_function( name_in = @pa_nam )
    FIELDS id,
           name,
           city,
           country
  ORDER BY country, city, name
INTO TABLE @gt_customers.

* output
*************************************************************
  TRY.

      cl_salv_table=>factory(
        IMPORTING
          r_salv_table   = go_salv
        CHANGING
          t_table        = gt_customers
      ).

* Display
*-------------------------*

      go_salv->display( ).

    CATCH cx_salv_error INTO gx_excp.    "
      MESSAGE gx_excp TYPE 'I'.
  ENDTRY.
