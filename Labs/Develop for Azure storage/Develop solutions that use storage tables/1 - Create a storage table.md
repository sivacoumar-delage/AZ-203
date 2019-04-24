# Create a storage table

## Lab 1: Create a storage table in Azure

:stopwatch: {duration} minutes

#### Task 1: Create a storage account called az203storageaccountXXXXX in Azure

*Ignore this task if the storage account already exists.*

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Create a resource**

1. In the **Azure Marketplace**, select **Storage**, then select **Storage account**

1. Next to **Subscription**, select a valid and active subscription

1. Next to **Resource group**, click **Create new**

1. In the popup, under **Name**, type *az203-rg*, then click **OK**

1. Next to **Storage account name**, type *az203storageaccountXXXXX* (replace XXXXX by a unique name)

1. Next to **Location**, select the location nearest to your location

1. Next to **Performance**, check **Standard**

1. Next to **Account kind**, select **StorageV2 (general purpose v2)**

1. Next to **Replication**, select **Read-access-geo-redundant storage (RA-GRS)**

1. Next to **Access tier (default)**, select **Hot**

1. Click **Review + create**

1. After completion of validation, click **Create**s

</details>

#### Task 2: Create a storage table called az203Table in the storage account az203storageaccountXXXXX

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in the previous task

1. In the **Storage account** blade, click **Tables** in the menu

1. In the **Tables** blade, click on the button **Table** in order to add a new storage table

1. In the **Add table** dialog, under **Name**, type *az203Table*

</details>

#### Task 3: Create a table policy called az203TablePolicy with full permissions

<details>
<summary>Click here to display answers</summary>

1. Next to the created table, click the **Ellipsis** button, then select **Access policy**

1. In the **Add policy** popup, under **Identifier**, type **az203TablePolicy**

1. Under **Permissions**, select all permissions

1. Click **OK**

1. In the **Access policy** blade, click **Save**

1. Close the **Access policy** blade

</details>

#### Task 4: Read entities from the az203Table table with a GET request

<details>
<summary>Click here to display answers</summary>

1. In **Azure**, copy the **URL** of the storage table

1. Go to **Shared access signature** and generate a **SAS token**

1. Append the **SAS token** after the copied **URL**

1. Open **Postman**

1. Paste the **URL** with **SAS token**

1. Change the method to **GET**

1. Click **SEND**

1. Check the **Response Body**

</details>

#### Task 5: Add new entities with a POST request

<details>
<summary>Click here to display answers</summary>

1. Open a new tab in Postman and duplicate the URL

1. Change the method to **POST**

1. Click **Body**, select **Raw** then selecy **JSON (application/json)**

1. In the JSON body, type the following:

    ```json
    {  
        "Address":"Mountain View",  
        "Age":23,  
        "AmountDue":987.45,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"1998-07-10T00:00:00",  
        "IsActive":true,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"255",  
        "PartitionKey":"Blue",  
        "RowKey":"Alpha"  
    }  
    ```

1. Click **SEND**

1. Repeat the previous two steps to add the following entities:

    ```json
    {  
        "Address":"Mountain View",  
        "Age":24,  
        "AmountDue":654.23,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"2008-07-10T00:00:00",  
        "IsActive":false,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"128",  
        "PartitionKey":"Blue",  
        "RowKey":"Beta"  
    }  
    ```

    ```json
    {  
        "Address":"Mountain View",  
        "Age":25,  
        "AmountDue":321.23,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"2018-07-10T00:00:00",  
        "IsActive":true,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"64",  
        "PartitionKey":"Blue",  
        "RowKey":"Omega"  
    }  
    ```

    ```json
    {  
        "Address":"Mountain View",  
        "Age":23,  
        "AmountDue":789.23,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"1998-07-10T00:00:00",  
        "IsActive":true,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"32",  
        "PartitionKey":"Green",  
        "RowKey":"Alpha"  
    }  
    ```

    ```json
    {  
        "Address":"Mountain View",  
        "Age":24,  
        "AmountDue":456.23,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"2008-07-10T00:00:00",  
        "IsActive":false,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"16",  
        "PartitionKey":"Green",  
        "RowKey":"Beta"  
    }  
    ```

    ```json
    {  
        "Address":"Mountain View",  
        "Age":25,  
        "AmountDue":123.23,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"2018-07-10T00:00:00",  
        "IsActive":true,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"8",  
        "PartitionKey":"Green",  
        "RowKey":"Omega"  
    }  
    ```

1. Run the request in the first tab, to check that the entities are in the table

</details>

#### Task 6: Update existing entities with a MERGE request

<details>
<summary>Click here to display answers</summary>

1. Add a new tab in **Postman**

1. Copy the same URL from previous tab

1. In the URL, replace *az203table* by c

1. Change the method to **MERGE**

1. Click **Body**, select **Raw** then selecy **JSON (application/json)**

1. In the JSON body, type the following:

    ```json
    {  
        "Address":"Paris",  
        "Age":24,  
        "AmountDue":654.23,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"2008-07-10T00:00:00",  
        "IsActive":true,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"128",  
        "PartitionKey":"Blue",  
        "RowKey":"Beta"  
    }  
    ```

1. Click **SEND**

1. Run the request in the first tab, to check the merge operation

</details>

#### Task 7: Update existing entities with a PUT request

<details>
<summary>Click here to display answers</summary>

1. In the third tab, in the URL, replace *az203table(PartitionKey='Blue', RowKey='Beta')* by *az203table(PartitionKey='Green', RowKey='Alpha')*

1. Change the method to **PUT**

1. In the JSON body, type the following:

    ```json
    {  
        "Comments":"New field added thanks to an UPDATE (PUT) request",  
        "Address":"Mountain View",  
        "Age":23,  
        "AmountDue":789.23,  
        "CustomerCode@odata.type":"Edm.Guid",  
        "CustomerCode":"c9da6455-213d-42c9-9a79-3e9149a57833",  
        "CustomerSince@odata.type":"Edm.DateTime",  
        "CustomerSince":"2008-07-10T00:00:00",  
        "IsActive":true,  
        "NumberOfOrders@odata.type":"Edm.Int64",  
        "NumberOfOrders":"32",  
        "PartitionKey":"Green",  
        "RowKey":"Alpha"  
    }  
    ```

1. Click **SEND**

1. Run the request in the first tab, to check the update operation

</details>

#### Task 8: Delete some entities with a DELETE request

<details>
<summary>Click here to display answers</summary>

1. In the third tab, in the URL, replace *az203table(PartitionKey='Green', RowKey='Alpha')* by *az203table(PartitionKey='Blue', RowKey='Omega')*

1. Change the method to **DELETE**

1. Empty the **JSON Body**

1. In the **Request Headers**, disable the **Content-Type**

1. Add the header **Date**, and in the **value**, add a date in the **YYYY-MM-DD** format

1. Add the header **If-Match**, and add a wildcard charcater (*) in the **value**

1. Click **SEND**

1. Run the request in the first tab, to check the delete operation

</details>

## Lab 2: Create a storage table in local with Microsoft Azure Storage Explorer

:stopwatch: 10 minutes

#### Task 1: Create a storage table called az203TableLocal in Azure Storage Emulator

<details>
<summary>Click here to display answers</summary>

1. Start **Microsoft Azure Storage Emulator**

1. Start **Microsoft Azure Storage Explorer**

1. Expand **Local & Attached** > **Storage Accounts** > **Emulator - Default Ports (Key)**

1. Right-click **Tables** and select **Create Table**

1. Type *az203TableLocal*

</details>

#### Task 2: Create a table policy called az203TablePolicy with full permissions

<details>
<summary>Click here to display answers</summary>

1. Right click the created storage table and select **Manage Access Policies...**

1. Click **Add**

1. Check all permissions

1. Click **Save**

</details>

#### Task 3: Add a new entity

<details>
<summary>Click here to display answers</summary>

1. Click **Add**

1. In the **Microsoft Azure Storage Explorer - Add Entity** window, next to **PartitionKey**, under **Value** type *Blue*

1. Next to **RowKey**, under **Value** type *Alpha*

1. Click **Add Property**, under **Property Name**, type **Age**

1. Under **Type**, select **Int32**, and type 23

1. Click **Insert**

</details>

#### Task 4: Update an existing entity

<details>
<summary>Click here to display answers</summary>

1. Click **Edit**

1. Click **Add Property**, under **Property Name**, type **Comments**

1. Under **Type**, select **String**, and type *New field*

1. Click **Update**

</details>

#### Task 5: Delete an entity

<details>
<summary>Click here to display answers</summary>

1. Click **Delete** and confirm

</details>