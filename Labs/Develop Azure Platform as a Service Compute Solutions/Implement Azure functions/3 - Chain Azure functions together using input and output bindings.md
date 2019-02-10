# Chain Azure functions together using input and output bindings

## Prerequisites

#### Task 1: Create a Function Apps named az203functions-InputOutput-XXXXX

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **App Services**

1. Click on the button **Add**

1. In the **Marketplace** blade, click **Function App**

1. Click **Create**

1. In the **Function App** blade, under **App name**, replace XXXXX by a unique name and type *az203functions-InputOutput-XXXXX*

1. Under **Subscription**, select your active and valid subscription

1. Under **Resource Group**, select **Use existing**, then select the *az203-rg* resource group

1. Under **OS**, leave the default value to **Windows**

1. Under **Hosting Plan**, leave the default value to **Consumption Plan**

    > **Note:** Hosting plan that defines how resources are allocated to your function app. In the default **Consumption Plan**, resources are added dynamically as required by your functions. In this serverless hosting, you only pay for the time your functions run. When you run in an **App Service Plan**, you must manage the scaling of your function app.

1. Under **Location**, select the nearest location

1. Under **Runtime Stack**, select **.NET**

   > **Note:** Choose a runtime that supports your favorite function programming language. Choose .NET for C# and F# functions.

1. Under **Storage**, select **Use existing**, then select the *az203storageaccountXXXXX* you created in a previous module

1. Under **Application Insights**, select **Disabled**

1. Click **Create**

## Task 2: Create a queue storage called az203queue in the az203storageaccountXXXXX storage account

## Task 3: Create a blob storage called az203blobs in the az203storageaccountXXXXX storage account

## Task 4: Create a table storage called az203table in the az203storageaccountXXXXX storage account

## Task 5: Create a Cosmos DB database called az203db-XXXXX with Core(SQL) API

</details>

## Lab 2: Write data with output bindings

> **Warning!** If the functions of a Function App returns an Http response 503 Service unavailable, and if the host is offline.
>
> Open Kudu and navigate to site/wwwroot and check if a file is named app_offline.htm
>
> If, yes, rename this file by adding the extension .old

#### Task 1: ...by sending an Http response

The HTTP response should be:

```json
{
    "message": "Hello from Azure Function",
    "comment": "az203"
}
```

<details>
<summary>Click here to display answers</summary>

1. Create a HTTP triggered function called *SendHttpResponse* in *az203functions-InputOutput-XXXXX*

1. Click **Integrate**

1. Under **Output** click **HTTP**

1. Under **HTTP output**, under **Response parameter name**, check the response variable name

    It should be *$return*

1. Click *SendHttpResponse*

1. Under **run.csx**, add the following class after the method Run:

```csharp
public class MyResponse
{
    public string message;
    public string comment;
}
```

1. Under **run.csx**, replace the content of the method Run with the following code:

```csharp
log.LogInformation("C# HTTP trigger function processed a request.");

var response = new MyResponse()
{
    message = "Hello from Azure Function",
    comment = "az203"
};
string jsonResponse = JsonConvert.SerializeObject(response);

return(ActionResult)new OkObjectResult(jsonResponse);
```

1. Click **Save and Run**

1. Check the response under **Output**

</details>

#### Task 2: ...by creating an item to a Queue storage

<details>
<summary>Click here to display answers</summary>

1. Create a HTTP triggered function called *AddItemToQueueStorage* in *az203functions-InputOutput-XXXXX*

1. Click **Integrate**

1. Under **Output**, click **New Output**

1. Select **Azure Queue Storage**

1. Click **Select**

1. Under **Extensions not Installed**, click **Install**

1. Under **Storage account connection**, click **new**

1. In the **Storage Account** pane, select *az203storageaccountXXXXX*

1. Under **Queue name**, type *az203queue*

1. Click **Save**

1. Under **Functions**, click *AddItemToQueueStorage*

1. Click **View files**, then open **function.json**

1. Check the binding associated to the new output to **Queue Storage**

```json
    {
      "type": "queue",
      "name": "outputQueueItem",
      "queueName": "az203queue",
      "connection": "az203storageaccountsde_STORAGE",
      "direction": "out"
    }
```

1. Open **run.csx**

1. Replace the Run signature by the following:

```csharp
public static async Task<IActionResult> Run(HttpRequest req, ICollector<string> outputQueueItem, ILogger log)
```

1. Add the following code before the return statement:

```csharp
outputQueueItem.Add("Alpha");
outputQueueItem.Add(name);
outputQueueItem.Add("Omega");
```

1. Click **Save and Run**

1. Go to the *az203storageaccountXXXXX* **Storage account**

1. Go to the az203queue **Queue**

    The new items should be added.

</details>

#### Task 3: ...by creating a file to a Blob storage

<details>
<summary>Click here to display answers</summary>

1. Create a HTTP triggered function called *CreateFileInBlobStorage* in *az203functions-InputOutput-XXXXX*

1. Click **Integrate**

1. Under **Output**, click **New Output**

1. Select **Azure Blob Storage**

1. Click **Select**

1. Under **Extensions not Installed**, click **Install**

1. Under **Storage account connection**, select *az203storageaccountXXXXX_STORAGE*

1. Under **Path**, type *az203blobs/{rand-guid}*

1. Click **Save**

1. Under **Function Apps**, click *CreateFileInBlobStorage*

1. Click **View files**, then open **function.json**

1. Check the binding associated to the new output to **Blob Storage**

```json
{
    "type": "blob",
    "name": "outputBlob",
    "path": "az203blobs/{rand-guid}",
    "connection": "az203storageaccountsde_STORAGE",
    "direction": "out"
}
```

1. Open **run.csx**

1. Add the following import module and using statements:

```csharp
#r "Microsoft.WindowsAzure.Storage"
using Microsoft.WindowsAzure.Storage.Blob;
using System.Text;
```

1. Replace the Run signature by the following:

```csharp
public static async Task<IActionResult> Run(HttpRequest req, CloudBlockBlob outputBlob, ILogger log)
```

1. Add the following method after the **Run** method:

```csharp
public static Stream ToStream(this string str)
{
    return new MemoryStream(Encoding.UTF8.GetBytes(str ?? string.Empty));
}
```

1. Add the following code before the return instruction in the **Run** method:

```csharp
await outputBlob.UploadFromStreamAsync(name.ToStream());
```

1. Click **Save and Run**

1. Go to the *az203storageaccountXXXXX* **Storage account**

1. Go to the az203queue **Queue**

    The new file should be added.

1. Right-click the blob and select **View/edit blob**

</details>

#### Task 4: ...by inserting a row in a Table Storage

<details>
<summary>Click here to display answers</summary>

1. Create a HTTP triggered function called *AddRowInTableStorage* in *az203functions-InputOutput-XXXXX*

1. Click **Integrate**

1. Under **Output**, click **New Output**

1. Select **Azure Table Storage**

1. Click **Select**

1. Under **Storage account connection**, select *az203storageaccountXXXXX_STORAGE*

1. Under **Path**, type *az203table*

1. Click **Save**

1. Under **Function Apps**, click *AddRowInTableStorage*

1. Click **View files**, then open **function.json**

1. Check the binding associated to the new output to **Azure Table Storage**

```json
{
    "type": "table",
    "name": "outputTable",
    "tableName": "az203table",
    "connection": "az203storageaccountXXXXX_STORAGE",
    "direction": "out"
}
```

1. Open **run.csx**

1. Add the following class after the method Run:

```csharp
public class User
{
    public string PartitionKey { get; set; }
    public string RowKey { get; set; }
    public string UserName { get; set; }
    public DateTime UserCreationDate { get; set; }

    public User(string name)
    {
        PartitionKey = name;
        RowKey = name;
        UserName = name;
        UserCreationDate = DateTime.UtcNow;
    }
}
```

1. Replace the Run signature by the following:

```csharp
public static async Task<IActionResult> Run(HttpRequest req, IAsyncCollector<User> outputTable, ILogger log)
```

1. Add the following code before the return instruction in the **Run** method:

```csharp
await outputTable.AddAsync(new User(name));
```

1. Click **Save and Run**

1. Open **Microsoft Azure Storage Explorer**

1. Navigate to the *az203table* **Table Storage**

1. Check that the new row has been added in the table

</details>

#### Task 5: ...by inserting a row in a Cosmos DB table

<details>
<summary>Click here to display answers</summary>

1. Create a HTTP triggered function called *InsertRowInCosmosDb* in *az203functions-InputOutput-XXXXX*

1. Click **Integrate**

1. Under **Output**, click **New Output**

1. Select **Azure Cosmos DB**

1. Click **Select**

1. Under **Extensions not Installed**, click **Install**

1. Under **Azure Cosmos DB account connection**, click **new**, then select the database account *az203db-XXXXX*

1. Check **If true, creates the Azure Cosmos DB database and collection**

1. Click **Save**

1. Under **Function Apps**, click *InsertRowInCosmosDb*

1. Click **View files**, then open **function.json**

1. Check the binding associated to the new output to **Azure Cosmos DB**

```json
{
    "type": "cosmosDB",
    "name": "outputDocument",
    "databaseName": "outDatabase",
    "collectionName": "MyCollection",
    "createIfNotExists": true,
    "connectionStringSetting": "az203db-XXXXX_DOCUMENTDB",
    "direction": "out"
}
```

1. Open **run.csx**

1. Replace the Run signature by the following:

```csharp
public static async Task<IActionResult> Run(HttpRequest req, IAsyncCollector<User> outputDocument, ILogger log)
```

1. Add the following class after the **Run** method:

```csharp
public class User
{
    public string UserName {get; set;}
    public DateTime CreationDate {get; set;}

    public User(string name)
    {
        UserName = name;
        CreationDate = DateTime.UtcNow;
    }
}
```

1. Add the following code before the return instruction in the **Run** method:

```csharp
await outputDocument.AddAsync(new User(name));
```

1. Click **Save and Run**

1. Go to the *az203db-XXXXX* **Cosmos DB account**

1. Click **Data Explorer**

1. Under **SQL API** expand **MyCollection** and select **Documents**

1. Check the document created

</details>

#### Task 6: ...by sending a mail

<details>
<summary>Click here to display answers</summary>

1. In a web browser, open a new tab and navigate to [SendGrid](https://sendgrid.com/)

1. Click **START FOR FREE**

1. In the **Pricing** page, select **Free**

1. Click **Try for free**

1. Create an **SendGrid** account

1. Verify your account with the link provided in the confirmation mail

1. In the left menu, expand **Settings* and click **API Keys**

1. Click **Create API Key**

1. In the **Create API Key** dialod, under **API Key Name**, type *az203sendGrid*

1. Click **Create & View**

1. Copy and save the API Key ID

1. Create a HTTP triggered function called *SendMail* in *az203functions-InputOutput-XXXXX*

1. Click **Integrate**

1. Under **Output**, click **New Output**

1. Select **SendGrid**

1. Click **Select**

1. Under **Extensions not Installed**, click **Install**

1. Under **SendGrid API Key App Setting**, click **new**

1. In the **Add app setting**, under **Key**, paste *az203sendGrid*

1. In the **Add app setting**, under **Value**, paste the API Key

1. CLick **Create**

1. Under **From address**, type *no-reply@az203.azure*

1. Under **To address**, type your email address

1. Click **Save**

1. Under **Function Apps**, click *SendMail*

1. Click **View files**, then open **function.json**

1. Check the binding associated to the new output to **SendGrid**

```json
    {
      "type": "sendGrid",
      "name": "message",
      "apiKey": "xxxxx",
      "from": "no-reply@az203.azure",
      "to": "xxx@yyy.zzz",
      "direction": "out"
    }
```

1. Open **run.csx**

1. Add the following import module and using statements:

    ```csharp
    #r "SendGrid"
    using SendGrid.Helpers.Mail;
    ```

1. Replace the Run signature by the following:

    ```csharp
    public static IActionResult Run(HttpRequest req, ILogger log, out SendGridMessage message)
    ```

1. Replace the content of the **Run** method with the following code:

    ```csharp
    log.LogInformation("C# HTTP trigger function processed a request.");

    string name = req.Query["name"];

    string requestBody = new StreamReader(req.Body).ReadToEnd();
    dynamic data = JsonConvert.DeserializeObject(requestBody);
    name = name ?? data?.name;

    message = new SendGridMessage();
    message.Subject = $"Cloud Application Development";
    string html = $"<p>Hello, {name}</p><p><img src=\"https://upload.wikimedia.org/wikipedia/en/thumb/3/3a/Avanade_logo17.png/250px-Avanade_logo17.png\" alt=\"Avanade Logo\" /><br />You will find attached the Avanade services for Microsoft Azure brochure.</p><p>Mail sent from SendGrid with Azure Function</p>";
    message.AddContent("text/html", html);
    
    var pdfAttachmentUrl = "https://www.avanade.com/~/media/asset/brochure/avanade-services-for-microsoft-azure-brochure.pdf";
    var httpClient = new HttpClient();
    var pdf = httpClient.GetByteArrayAsync(pdfAttachmentUrl).Result;
    var attachment = System.Convert.ToBase64String(pdf);
    var filename = "Avanade services for Microsoft Azure brochure.pdf";
    message.AddAttachment(filename, attachment);
    
    // message.AddTo(new EmailAddress("sivacoumar.delage@gmail.com", "Sivacoumar Delage"));
    // message.From = new EmailAddress("no-reply@az203.azure");

    return name != null
        ? (ActionResult)new OkObjectResult($"Hello, {name}")
        : new BadRequestObjectResult("Please pass a name on the query string or in the request body");
    ```

    > **Note:** The method seems to not be working asynchronously

1. Click **Save and Run**

1. Check that the **Logs** are correct, and that the **Output** displays a 200 OK status

1. In the **SendGrid** tab, click **Activity** and check that the request has been been received

1. Check your mails (check in spam)

</details>

## Lab 2: Read data with input bindings

#### Task 1: ...from a Http trigger

Create a HTTP triggered function called *ReadHttpRequest* expecting the following **Request Body**:

```json
{
    "userId": "httpTrigger@az203.azure",
    "profilePictureUrl": "https://www.avanade.com/~/media/images/content/background/thinking/technology-vision-2016.jpg"
}
```

The function should log each attribute.

<details>
<summary>Click here to display answers</summary>

1. Go to the *az203functions-Portal-XXXXX* **Function App** 

1. Expand the *DownloadPictureFromUrl* function, click **Integrate**

1. 

</details>

#### Task 2: ...from a Queue trigger

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: ...from a Blob trigger

<details>
<summary>Click here to display answers</summary>

1. Step 1  

1. Step 2

</details>

## Lab 3: Chain Azure functions together

#### Task 1: Create a function with an Http trigger and a Queue storage output

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Create a function with a Queue trigger and a Blob storage output

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: Create a function with a Blob trigger and a mail output

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 4: Test the chain

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 4: Design and implement a custom binding

#### Task 1: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>