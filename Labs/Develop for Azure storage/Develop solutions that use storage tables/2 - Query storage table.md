# Query storage table

## Lab 1: Query storage table from HTTP requests

:stopwatch: 5 minutes

#### Task 1: Select PartitionKey, RowKey and AmountDue fields

<details>
<summary>Click here to display answers</summary>

1. In **Azure**, copy the **URL** of the storage table

1. Go to **Shared access signature** and generate a **SAS token**

1. Append the **SAS token** after the copied **URL**

1. Open **Postman**

1. Paste the **URL** with **SAS token**

1. In the **URL**, append the following:

    ```text
    &$select=PartitionKey,RowKey,AmountDue
    ```

1. Change the method to **GET**

1. Click **SEND**

1. Check the **Response Body**

1. Disable the *$select* request parameter

</details>

#### Task 2: Return the Top 2 entities

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, append the following:

    ```text
    &$top=2
    ```

1. Click **SEND**

1. Check the **Response Body**

1. Disable the *$top* request parameter

</details>

#### Task 3: Filter on Green partition key

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, append the following:

    ```text
    &$filter=PartitionKey eq 'Green'
    ```

1. Click **SEND**

1. Check the **Response Body**

</details>

#### Task 4: Filter on entities with AmountDue less than 500

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, replace the *filter* parameter with:

    ```text
    AmountDue lt 500
    ```

1. Click **SEND**

1. Check the **Response Body**

</details>

#### Task 5: Filter on entities with AmountDue greater than 500 and living in Mountain View

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, replace the *filter* parameter with:

    ```text
    Address eq 'Mountain View' and AmountDue gt 500
    ```

1. Click **SEND**

1. Check the **Response Body**

</details>

#### Task 6: Filter on active customers

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, replace the *filter* parameter with:

    ```text
    IsActive eq true
    ```

1. Click **SEND**

1. Check the **Response Body**

</details>

#### Task 7: Filter on inactive customers or with AmountDue less than 500

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, replace the *filter* parameter with:

    ```text
    IsActive eq false or AmountDue lt 500
    ```

1. Click **SEND**

1. Check the **Response Body**

</details>

#### Task 8: Filter on customers since 2008 included

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, replace the *filter* parameter with:

    ```text
    CustomerSince ge datetime'2008'
    ```

1. Click **SEND**

1. Check the **Response Body**

</details>

#### Task 9: Filter on customers between 2000 and 2010

<details>
<summary>Click here to display answers</summary>

1. In Postman, in the **URL**, replace the *filter* parameter with:

    ```text
    CustomerSince gt datetime'2000' and CustomerSince lt datetime'2010'
    ```

1. Click **SEND**

1. Check the **Response Body**

</details>

## Lab 2: Perform single operations on a storage table from a .NET Core application

:stopwatch: 10 minutes

#### Task 1: Get the connection string of the az203storageaccountXXXXX storage account

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in the previous lab

1. In the **Storage account** blade, click **Access keys** in the menu

1. In the **Access keys** blade, copy the **Connection string** of the master key

</details>

#### Task 2: Create a .NET Core console application

<details>
<summary>Click here to display answers</summary>

1. Open **Visual Studio**

1. Click the menu **File** > **New** > **Project...**

1. In the **New Project** window, expand **Visual C#** and select **.NET Core**, then select **Console App (.NET Core)**

1. Next to **Name**, type *TableStorageSample*

1. Click **OK**

</details>

#### Task 3: Create an appsettings.json file and add the storage account connection string

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, right-click the *TableStorageSample* project and select **Add** > **New Item...**

1. In the **Add New Item - TableStorageSample** window, select **JSON File**

1. Next to **Name**, type *appsettings.json*

1. Click **Add**

1. Open the *appsettings.json* file

1. Add the *ConnectionStrings* section

1. Add *Storage* and paste the connection string

1. In the **Solution Explorer**, right-click the *appsettings.json* file, displays the **Properties**

1. In the **Properties**, next to **Copy to Output Directory** select **Copy always**

</details>

#### Task 4: Add the Microsoft.Extensions.Configuration.Json NuGet package

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, right-click the *TableStorageSample* project and select **Manage NuGet Packages...**

1. In **NuGet: TableStorageSample**, select the **Browse** tab

1. Search and select *Microsoft.Extensions.Configuration.Json*

1. Click **Install**

1. In the **License Acceptance** popup, click **I Accept**

1. Close **NuGet: TableStorageSample**

</details>

#### Task 5: Read the storage connection string from the configuration file

<details>
<summary>Click here to display answers</summary>

1. In the **Main** method, add the following code:

    ```csharp
    var configuration = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json", 
            optional: true, 
            reloadOnChange: true)
        .Build();

    var connectionstring = ConfigurationExtensions
        .GetConnectionString(configuration, "Storage");
    ```

</details>

#### Task 6: Add the WindowsAzure.Storage NuGet package

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, right-click the *TableStorageSample* project and select **Manage NuGet Packages...**

1. In **NuGet: TableStorageSample**, select the **Browse** tab

1. Search and select *WindowsAzure.Storage*

1. Click **Install**

1. In the **License Acceptance** popup, click **I Accept**

1. Close **NuGet: TableStorageSample**

</details>

#### Task 7: Read the Azure storage connection string from configuration

Add the following call in the main method and implement the method:

```csharp
string connectionString = ReadConnectionStringFromConfiguration();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **ReadConnectionStringFromConfiguration** as follow:

    ```csharp
    private static string ReadConnectionStringFromConfiguration()
    {
        var configuration = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json",
            optional: true,
            reloadOnChange: true)
        .Build();

        return ConfigurationExtensions
            .GetConnectionString(configuration, "Storage");
    }
    ```

</details>

#### Task 8: Create a static class to perform single operations

Add the following call in the main method and implement the **SingleDataOperations** class and **RunSample** method:

```csharp
SingleDataOperations.RunSample(connectionString, "az203tableSingle");
```

#### Task 9: Recreate a storage table

Call the following method in the **RunSample** method and implement the **RecreateTableAsync** method:

```csharp
RecreateTableAsync(connectionString, tableName)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **RecreateTableAsync** as follow:

    ```csharp
    private static async Task RecreateTableAsync(string connectionString, string tableName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        if (await table.ExistsAsync())
        {
            Console.WriteLine($"Deleting table {tableName}...");
            await table.DeleteIfExistsAsync();
            await Task.Delay(60 * 1000);
        }

        if (!await table.ExistsAsync())
        {
            Console.WriteLine($"Creating table {tableName}...");
            await table.CreateIfNotExistsAsync();
        }
    }
    ```

    > **Note:** A delay of one minute seems required to allow recreation of a table, a conflict is raised otherwise

</details>

#### Task 10: Create an entity class called MyEntity

The **MyEntity** class should inherit the **TableEntity** class.

The class should also have a parameterless constructor.

The class should have the following properties:

| Property name  | Property type |
|----------------|---------------|
| Age            | Integer       |
| Address        | String        |
| AmountDue      | Decimal       |
| CustomerSince  | Date          |
| NumberOfOrders | Integer       |
| IsActive       | Boolean       |

<details>
<summary>Click here to display answers</summary>

1. Implement the **MyEntity** class as follow:

    ```csharp
    public class MyEntity : TableEntity
    {
        public MyEntity()
        {
        }

        public int Age { get; set; }
        public string Address { get; set; }
        public double AmountDue { get; set; }
        public DateTime? CustomerSince { get; set; }
        public long NumberOfOrders { get; set; }
        public bool IsActive { get; set; }
    }
    ```
    
</details>

#### Task 11: Generate the following sample data from the MyEntity.GetSampleEntities static method

| PartitionKey | RowKey | Age | Address       | AmountDue | CustomerSince | NumberOfOrders | IsActive |
|--------------|--------|-----|---------------|-----------|---------------|----------------|----------|
| Blue         | Alpha  | 23  | Mountain View | 987.45    | 07/10/1998    | 255            | true     |
| Blue         | Beta   | 24  | Mountain View | 654.45    | 07/10/2008    | 128            | false    |
| Blue         | Omega  | 25  | Mountain View | 321.45    | 07/10/2018    | 64             | true     |
| Green        | Alpha  | 23  | Mountain View | 789.45    | 07/10/1998    | 32             | true     |
| Green        | Beta   | 24  | Mountain View | 456.45    | 07/10/2008    | 16             | false    |
| Green        | Omega  | 25  | Mountain View | 123.45    | 07/10/2018    | 8              | true     |

<details>
<summary>Click here to display answers</summary>

1. Add a constructor in the **MyEntity** class with all properties as follow:

```csharp
    public MyEntity(
        string partitionKey,
        string rowKey,
        int age = 0,
        string address = null,
        double amountDue = 0,
        DateTime? customerSince = null,
        long numberOfOrders = 0,
        bool isActive = true
        )
        : base(partitionKey, rowKey)
    {
        Age = age;
        Address = address;
        AmountDue = amountDue;
        CustomerSince = customerSince;
        NumberOfOrders = numberOfOrders;
        IsActive = isActive;
    }
```

1. Add and implement the method **GetSampleEntities** as follow:

    ```csharp
    public static IList<MyEntity> GetSampleEntities()
    {
        var entities = new List<MyEntity>();

        entities.Add(new MyEntity("Blue", "Alpha", 23, "Mountain View", 987.45, new DateTime(1998, 07, 10), 255, true));
        entities.Add(new MyEntity("Blue", "Beta", 24, "Mountain View", 654.45, new DateTime(2008, 07, 10), 128, false));
        entities.Add(new MyEntity("Blue", "Omega", 25, "Mountain View", 321.45, new DateTime(2018, 07, 10), 64, true));
        entities.Add(new MyEntity("Green", "Alpha", 23, "Mountain View", 789.45, new DateTime(1998, 07, 10), 32, true));
        entities.Add(new MyEntity("Green", "Beta", 24, "Mountain View", 456.45, new DateTime(2008, 07, 10), 16, false));
        entities.Add(new MyEntity("Green", "Omega", 25, "Mountain View", 123.45, new DateTime(2018, 07, 10), 8, true));

        return entities;
    }
    ```
    
</details>

#### Task 12: Override the ToString method of the MyEntity class to display all properties

<details>
<summary>Click here to display answers</summary>

1. Override the method **ToString** as follow:

    ```csharp
    public override string ToString()
    {
        return $"{PartitionKey};{RowKey};{Age};{Address};{AmountDue};{CustomerSince}{NumberOfOrders};{IsActive}";
    }
    ```

#### Task 13: Insert sample data in the storage table

Call the following method in the **RunSample** method and implement the **InsertAsync** method:

```csharp
InsertAsync(connectionString, tableName, MyEntity.GetSampleEntities())
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **InsertAsync** as follow:

    ```csharp
    private static async Task InsertAsync(
        string connectionString,
        string tableName,
        IEnumerable<MyEntity> entities
    )
    {
        Console.WriteLine("Inserting entities...");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        foreach (var entity in entities)
        {
            await table.ExecuteAsync(TableOperation.Insert(entity));
        }

        Console.WriteLine("Entities inserted");
    }
    ```
    
</details>

#### Task 14: Read an entity from the storage table

Call the following method in the **RunSample** method and implement the **ReadAsync** method:

```csharp
var entity = ReadAsync(connectionString, tableName,
        "Blue", "Beta")
    .GetAwaiter()
    .GetResult();
    Console.WriteLine($"\t{entity}");
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **ReadAsync** as follow:

    ```csharp
    private static async Task<MyEntity> ReadAsync(
        string connectionString, 
        string tableName, 
        string partitionKey, 
        string rowKey)
    {
        Console.WriteLine($"Retrieving entity (PartitionKey = {partitionKey} ; RowKey = {rowKey})...");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableResult tableResult = await table.ExecuteAsync(TableOperation.Retrieve<MyEntity>(partitionKey, rowKey));
        MyEntity entity = (MyEntity) tableResult.Result;
        Console.WriteLine("Entity retrieved");

        return entity;
    }
    ```
    
</details>

#### Task 15: Update an entity

Call the following methods in the **RunSample** method and implement the **UpdateAsync** method:

```csharp
entity.Address = "Paris";
    UpdateAsync(connectionString, tableName, entity)
    .GetAwaiter()
    .GetResult();

entity = ReadAsync(connectionString, tableName, "Blue", "Beta")
    .GetAwaiter()
    .GetResult();
Console.WriteLine($"\t{entity}");
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **UpdateAsync** as follow:

    ```csharp
    private static async Task UpdateAsync(
        string connectionString,
        string tableName,
        MyEntity entity
    )
    {
        Console.WriteLine("Updating entity...");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        await table.ExecuteAsync(TableOperation.Merge(entity));

        Console.WriteLine("Entity updated");
    }
    ```
    
</details>

#### Task 16: Delete an entity

Call the following method in the **RunSample** method and implement the **DeleteAsync** method:

```csharp
DeleteAsync(connectionString, tableName, entity)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **DeleteAsync** as follow:

    ```csharp
    private static async Task DeleteAsync(
        string connectionString, 
        string tableName, 
        MyEntity entity)
    {
        Console.WriteLine($"Deleting entity (PartitionKey = {entity.PartitionKey} ; RowKey = {entity.RowKey})...");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableResult tableResult = await table.ExecuteAsync(TableOperation.Delete(entity));
        Console.WriteLine("Entity deleted");
    }
    ```
    
</details>

## Lab 3: Perform batch operations on a storage table from a .NET Core application

:stopwatch: 10 minutes

#### Task 1: Create a static class to perform batch operations

Add the following call in the main method and implement the **BatchDataOperations** class and **RunSample** method:

```csharp
BatchDataOperations.RunSample(connectionString, "az203tableBatch");
```

#### Task 2: Recreate a storage table

Call the following method in the **RunSample** method and implement the **RecreateTableAsync** method:

```csharp
RecreateTableAsync(connectionString, tableName)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. See Lab 2, Task 9
    
</details>

#### Task 3: Insert entites

Call the following methods in the **RunSample** method and implement the **BatchInsertAsync** method:

```csharp
IEnumerable<MyEntity> entities = MyEntity.GetSampleEntities();
IEnumerable<MyEntity> blueEntities = entities
    .Where(entity => entity.PartitionKey == "Blue");
IEnumerable<MyEntity> greenEntities = entities
    .Where(entity => entity.PartitionKey == "Green");

BatchInsertAsync(connectionString, tableName, blueEntities)
    .GetAwaiter()
    .GetResult();
BatchInsertAsync(connectionString, tableName, greenEntities)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **BatchInsertAsync** as follow:

    ```csharp
    private static async Task BatchInsertAsync(
        string connectionString,
        string tableName,
        IEnumerable<MyEntity> entities
    )
    {
        string partitionKey = entities.First().PartitionKey;
        Console.WriteLine($"Inserting entities for partition {partitionKey}...");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableBatchOperation operations = new TableBatchOperation();
        foreach (MyEntity entity in entities)
            operations.Add(TableOperation.Insert(entity));

        await table.ExecuteBatchAsync(operations);

        Console.WriteLine("Entities inserted");
    }
    ```
    
</details>

#### Task 4: Update entites

Call the following method in the **RunSample** method and implement the **BatchUpdateAsync** method:

```csharp
entities
    .Where(entity => entity.RowKey == "Beta")
    .ToList()
    .ForEach(entity => entity.Address = "Paris");

BatchUpdateAsync(connectionString, tableName, blueEntities)
    .GetAwaiter()
    .GetResult();
BatchUpdateAsync(connectionString, tableName, greenEntities)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **BatchUpdateAsync** as follow:

    ```csharp
    private static async Task BatchUpdateAsync(
        string connectionString,
        string tableName,
        IEnumerable<MyEntity> entities
    )
    {
        string partitionKey = entities.First().PartitionKey;
        Console.WriteLine($"Updating entities for partition {partitionKey}...");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableBatchOperation operations = new TableBatchOperation();
        foreach (MyEntity entity in entities)
            operations.Add(TableOperation.Merge(entity));

        await table.ExecuteBatchAsync(operations);

        Console.WriteLine("Entities updated");
    }
    ```
    
</details>

#### Task 5: Delete entites

Call the following method in the **RunSample** method and implement the **BatchDeleteAsync** method:

```csharp
IEnumerable<MyEntity> omegaEntities = entities
    .Where(entity => entity.RowKey == "Omega");

BatchDeleteAsync(
    connectionString, 
    tableName, 
    omegaEntities
        .Where(entity => entity.PartitionKey == "Blue"))
    .GetAwaiter()
    .GetResult();
BatchDeleteAsync(
    connectionString, 
    tableName, 
    omegaEntities
        .Where(entity => entity.PartitionKey == "Green"))
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **BatchDeleteAsync** as follow:

    ```csharp
    private static async Task BatchDeleteAsync(
        string connectionString, 
        string tableName, 
        IEnumerable<MyEntity> entities)
    {
        string partitionKey = entities.First().PartitionKey;
        Console.WriteLine($"Deleting entities for partition {partitionKey}...");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableBatchOperation operations = new TableBatchOperation();
        foreach (MyEntity entity in entities)
            operations.Add(TableOperation.Delete(entity));

        await table.ExecuteBatchAsync(operations);

        Console.WriteLine("Entity deleted");
    }
    ```
    
</details>

## Lab 3: Perform batch operations on a storage table from a .NET Core application

:stopwatch: 10 minutes

#### Task 1: Create a static class to run the queries

Add the following call in the main method and implement the **QueryingEntities** class and **RunSample** method:

```csharp
QueryingEntities.RunSample(connectionString, "az203tableBatch");
```

#### Task 2: Get all entites

Call the following method in the **RunSample** method and implement the **GetAllEntitiesAsync** method:

```csharp
GetAllEntitiesAsync(connectionString, tableName)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **GetAllEntitiesAsync** as follow:

    ```csharp
    private static async Task GetAllEntitiesAsync(
    string connectionString, 
    string tableName)
    {
        Console.WriteLine("Get all entities");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableQuery<MyEntity> query = new TableQuery<MyEntity>();

        var querySegment = await table.ExecuteQuerySegmentedAsync<MyEntity>(query, null);
        querySegment
            .Results
            .ToList()
            .ForEach(entity => Console.WriteLine("\t" + entity));

        Console.WriteLine(Environment.NewLine);
    }
    ```
    
</details>

#### Task 3: Take n entities

Call the following method in the **RunSample** method and implement the **TakeEntitesAsync** method:

```csharp
TakeEntitesAsync(connectionString, tableName, 3)
    .GetAwaiter()
    .GetResult();

TakeEntitesAsync(connectionString, tableName, 1)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **TakeEntitesAsync** as follow:

    ```csharp
    private static async Task TakeEntitesAsync(
        string connectionString, 
        string tableName, 
        int takeCount)
    {
        string unitLabel = takeCount > 1 ? "entities" : "entity";
        Console.WriteLine($"Returning the top {takeCount} {unitLabel}");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableQuery<MyEntity> query = new TableQuery<MyEntity>()
            .Take(takeCount);

        var querySegment = await table.ExecuteQuerySegmentedAsync<MyEntity>(query, null);
        querySegment
            .Results
            .ToList()
            .ForEach(entity => Console.WriteLine("\t" + entity));

        Console.WriteLine(Environment.NewLine);
    }
    ```
    
</details>

#### Task 4: Select the distinct adresses from entities

Call the following method in the **RunSample** method and implement the **SelectDistinctAddressesAsync** method:

```csharp
SelectDistinctAddressesAsync(connectionString, tableName)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **SelectDistinctAddressesAsync** as follow:

    ```csharp
    private static async Task SelectDistinctAddressesAsync(
        string connectionString, 
        string tableName)
    {
        Console.WriteLine("Select distinct addresses");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        IList<string> columns = new List<string>();
        columns.Add("Address");

        TableQuery<MyEntity> query =
            new TableQuery<MyEntity>()
            .Select(columns);
        // Partition Key and Row Key are automatically returned as well

        var querySegment = await table.ExecuteQuerySegmentedAsync<MyEntity>(query, null);
        querySegment
            .Results
            .Select(a => a.Address)
            .Distinct()
            .ToList()
            .ForEach(a => Console.WriteLine("\t" + a));

        Console.WriteLine(Environment.NewLine);
    }
    ```
    
</details>

#### Task 5: Filter entities

Call the following method in the **RunSample** method and implement the **FilterEntitiesAsync** method:

```csharp
FilterEntitiesAsync(connectionString, tableName, "Address eq 'Mountain View'")
    .GetAwaiter()
    .GetResult();

FilterEntitiesAsync(connectionString, tableName, "AmountDue lt 500")
    .GetAwaiter()
    .GetResult();

FilterEntitiesAsync(connectionString, tableName, "Address eq 'Mountain View' and AmountDue gt 500")
    .GetAwaiter()
    .GetResult();

FilterEntitiesAsync(connectionString, tableName, "IsActive eq true")
    .GetAwaiter()
    .GetResult();

FilterEntitiesAsync(connectionString, tableName, "IsActive eq false or AmountDue lt 500")
    .GetAwaiter()
    .GetResult();

FilterEntitiesAsync(connectionString, tableName, "CustomerSince gt datetime'2000' and CustomerSince lt datetime'2010'")
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method **FilterEntitiesAsync** as follow:

    ```csharp
    private static async Task FilterEntitiesAsync(
        string connectionString, 
        string tableName, 
        string queryFilter)
    {
        Console.WriteLine($"Filtering on entities ({queryFilter})");

        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
        CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
        CloudTable table = tableClient.GetTableReference(tableName);

        TableQuery<MyEntity> query = new TableQuery<MyEntity>()
            .Where(queryFilter);

        var querySegment = await table.ExecuteQuerySegmentedAsync<MyEntity>(query, null);
        querySegment
            .Results
            .ToList()
            .ForEach(entity => Console.WriteLine("\t" + entity));

        Console.WriteLine(Environment.NewLine);
    }
    ```
    
</details>