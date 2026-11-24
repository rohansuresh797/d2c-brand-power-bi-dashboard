let
    Source = Excel.Workbook(File.Contents("C:\Users\USER\Desktop\Project\Case Data\Additional Information\Product and Cost Details.xlsx"), null, true),
    #"Product List_Sheet" = Source{[Item="Product List",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Product List_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"SKU_Code", type text}, {"Product_Name", type text}, {"Category", type text}, {"Pack_Size", type text}, {"MRP", Int64.Type}, {"Ship_Length_cm", Int64.Type}, {"Ship_Width_cm", Int64.Type}, {"Ship_Height_cm", Int64.Type}})
in
    #"Changed Type"
