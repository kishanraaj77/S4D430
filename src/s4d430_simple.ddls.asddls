@AbapCatalog.sqlViewName: 'S4D430_SIMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Simple CDS View Definition'
define view S4D430_Simple
  as select from sbook
{
  key  carrid,
  key  connid,
  key  fldate,
  key  bookid,
       class,
       forcuram,
       forcurkey,
       luggweight,
       wunit,
       order_date,
       agencynum,
       counter,
       customid
}
