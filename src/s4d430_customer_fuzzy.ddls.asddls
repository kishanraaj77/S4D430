@EndUserText.label: 'Solution: Table Function'
define table function S4D430_Customer_Fuzzy
with parameters name_in : s_custname 
returns {
            mandt   : mandt;
            id      : s_customer;
            name    : s_custname; 
            city    : s_city;
            country : s_country;
}
implemented by method CL_S4D430_TABLE_FUNC_S1=>CUSTOMER_FUZZY;
