@AbapCatalog.sqlViewName: 'S4D430_CUST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Flight Customer w Calculations'
define view s4d430_Customer
  as select from scustom as c
{
  key c.id,
      concat_with_space(c.form, c.name, 1)            as name,
      // concat(concat( c.form, ' '), c.name) as name, // Workaround in 7.40
      c.street,
      c.postcode,
      c.city,
      c.country,
      @EndUserText.label: 'Discount Factor'
      @EndUserText.quickInfo: 'Customer Specific Discount Factor'
      division(cast(c.discount as abap.int4), 100, 2) as discount
}
