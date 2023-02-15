@AbapCatalog.sqlViewName: 'S4D430EXPR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Expressions'

define view S4D430_Expressions
  as select from sbook   as b
    inner join   scustom as c on b.customid = c.id
{
  key b.carrid,
  key b.connid,
  key b.fldate,
  key b.bookid,
      case b.class
       when 'Y' then 'Economy'
       when 'C' then 'Business'
       when 'F' then 'First'
       else '???'
      end                                          as class,
      @Semantics.amount.currencyCode:'currency'
      b.forcuram                                   as amount,
      @Semantics.currencyCode: true
      b.forcurkey                                  as currency,
      @Semantics.quantity.unitOfMeasure: 'wunit'
      b.luggweight,
      @Semantics.unitOfMeasure: true
      b.wunit,
      b.order_date,
      b.agencynum,
      b.counter,
      b.customid,
      c.name,
      c.street,
      c.postcode,
      c.city,
      c.country,
      @EndUserText.label: 'Discount Factor'
      @EndUserText.quickInfo: 'Customer Specific Discount Factor'
      cast(c.discount as abap.fltp(16,16)) / 100.0 as discount
}
where
  cancelled <> 'X'
