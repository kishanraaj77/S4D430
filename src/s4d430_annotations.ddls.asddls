@AbapCatalog.sqlViewName: 'S4D430_ANNO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: ABAP Annotations'

@AbapCatalog.buffering.type: #GENERIC
@AbapCatalog.buffering.numberOfKeyFields: 4
@AbapCatalog.buffering.status: #ACTIVE

define view S4D430_Annotations
  as select from sbook   as b
      inner join scustom as c on b.customid = c.id
{
  key b.carrid,
  key b.connid,
  key b.fldate,
  key b.bookid,
      b.class,
      @Semantics.amount.currencyCode:'currency'
      b.forcuram  as amount,
      @Semantics.currencyCode: true
      b.forcurkey as currency,
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
      c.country
}
where
  cancelled <> 'X'
