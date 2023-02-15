CLASS cl_s4d430_table_func_s1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS customer_fuzzy FOR TABLE FUNCTION s4d430_customer_fuzzy.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_S4D430_TABLE_FUNC_S1 IMPLEMENTATION.


  METHOD customer_fuzzy    BY DATABASE FUNCTION
                           FOR HDB LANGUAGE SQLSCRIPT
                           OPTIONS READ-ONLY
                           USING scustom.

    RETURN SELECT mandt, id, name, city, country
             FROM scustom
            WHERE contains( name, :name_in, fuzzy )
            ORDER BY score( ) desc;

  ENDMETHOD.
ENDCLASS.
