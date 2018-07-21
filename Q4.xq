(:For each rep number, output
1- firstname, lastname of the rep
2- customer name for each customer associated with the rep
3- total amount of money (excluding tax) billed for for all customers associated
with the rep:)

<results>
{
  for $r in doc("../premiere/Rep.xml")//Rep
  let $c := doc("../premiere/Customer.xml")//Customer[RepNum = $r/RepNum]
  return 
    <rep>{
      <rep repnum = "{$r/RepNum}" firstname="{$r/FirstName}" lastname="{$r/LastName}"/>,

      for $customer in $c 
      return <customer name="{$customer/CustomerName}"/>,

      let $total :=
        sum(
          for $customer in $c
          for $order in doc("../premiere/Orders.xml")//Orders[CustomerNum = $customer/CustomerNum]
          for $lineItem in doc("../premiere/OrderLine.xml")//OrderLine[OrderNum = $order/OrderNum]
          return $lineItem/NumOrdered * $lineItem/QuotedPrice
        )
      return <Revenue total="{format-number($total, '$,000.00')}"/>
   }
   </rep>
}
</results>