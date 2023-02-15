@AbapCatalog.sqlViewName: 'S4D430PARTREV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Union of Customers & Agencies'
define view S4D430_Partner_With_Revenue
  as select from S4d430_Customer_With_Revenue
{
  key id,
      'C' as type,
      name,
      street,
      postcode,
      city,
      country,
      amount,
      currency,
      days_ahead
}

union all

select from S4d430_Agency_With_Revenue
{
  key id,
      'A' as type,
      name,
      street,
      postcode,
      city,
      country,
      amount,
      currency,
      days_ahead
}
