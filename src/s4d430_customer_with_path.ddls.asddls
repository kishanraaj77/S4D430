@AbapCatalog.sqlViewName: 'S4D430_CUSTPATH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Path Expressions in CDS DDL'
define view S4d430_Customer_With_Path
  with parameters
    @EndUserText.label: 'Consider flights up to this date'
    @Environment.systemField: #SYSTEM_DATE
    P_FlightsBefore : abap.dats
  as select from S4d430_Association as c
{
  key c.customid        as id,
      c._Customer.name,
      c._Customer.street,
      c._Customer.postcode,
      c._Customer.city,
      c._Customer.country,
      @Semantics.amount.currencyCode: 'currency'
      sum(c.amount)     as amount,
      // @Semantics.currencyCode: true
      c.currency,
      avg(c.days_ahead) as days_ahead
}
where
  c.fldate < $parameters.P_FlightsBefore
group by
  c.customid,
  c._Customer.name,
  c._Customer.street,
  c._Customer.postcode,
  c._Customer.city,
  c._Customer.country,
  c.currency
