CLASS cl_s4d430_table_func_t1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

       CLASS-METHODS customer_fuzzy.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS CL_S4D430_TABLE_FUNC_T1 IMPLEMENTATION.


 METHOD customer_fuzzy.
*                         BY DATABASE FUNCTION
*                          FOR HDB LANGUAGE SQLSCRIPT
*                          OPTIONS READ-ONLY
*                          USING scustom.
*
*    return select mandt, id, name
*             from scustom
*            where contains( name, :name_in, fuzzy )
*            order by score( ) desc;

  ENDMETHOD.
ENDCLASS.
