let
    Source = Fact_Sales,
    #"Removed Columns" = Table.RemoveColumns(Source,{"Sales_Date", "Delivery_Date", "SKU_Code", "Qty", "Unit_Price", "Line_Amount", "Source.Name", "From_Location", "To_Location", "Channel", "Sub_Channel", "Delivery_Type", "City_Tier", "Category", "Order_ID", "Customer_ID", "Payment_Method", "Is_Returned", "Rider_Distance_Km", "Year", "Month", "Week of Year", "Duration_Days"}),
    #"Removed Duplicates" = Table.Distinct(#"Removed Columns"),
    #"Removed Columns1" = Table.RemoveColumns(#"Removed Duplicates",{"Channel_Key"}),
    #"Removed Other Columns" = Table.SelectColumns(#"Removed Columns1",{"Courier"}),
    #"Removed Duplicates1" = Table.Distinct(#"Removed Other Columns")
in
    #"Removed Duplicates1"
