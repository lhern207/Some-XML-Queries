(:Output the customer names of each pair of customers who are associated 
with the same rep. There should not be any duplicate reversed pair and no 
customer be paired with the same customer.:)

<results>
  {
    for $c in doc("../premiere/Customer.xml")//Customer,
        $e in doc("../premiere/Customer.xml")//Customer
    where $c/CustomerName < $e/CustomerName and $e/RepNum = $c/RepNum
    return 
      <pair>
        {data($c/CustomerName)} - {data($e/CustomerName)}
      </pair>
  }
</results>  