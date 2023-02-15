@AbapCatalog.sqlViewName: 'S4D430CUSTPARAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Input Parameter'
define view S4d430_Customer_With_Parameter
  with parameters
    @EndUserText.label: 'Consider flights up to this data'
    @Environment.systemField: #SYSTEM_DATE
    P_FlightsBefore : abap.dats
  as select from S4d430_Booking_And_Customer as c
{
  key c.customid        as id,
      c.name,
      c.street,
      c.postcode,
      c.city,
      c.country,
      @Semantics.amount.currencyCode: 'currency'
      sum(c.amount)     as amount,
      //     @Semantics.currencyCode: true
      c.currency,
      avg(c.days_ahead) as days_ahead
}
where
  fldate < $parameters.P_FlightsBefore
group by
  c.customid,
  c.name,
  c.postcode,
  c.street,
  c.city,
  c.country,
  c.currency
