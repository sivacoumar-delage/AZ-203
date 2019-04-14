# Set and retrieve properties and metadata

## Lab 1: Setting and retrieving properties

:stopwatch: 5 minutes

#### Task 1: Open the solution BlobStorageSample in Visual Studio

#### Task 2: Read the following properties of the az203-blob-storage container and of the AvanadeLogo.png blob

| Resource  | Property          |
|-----------|-------------------|
| Container | Last modified UTC |
| Container | ETag              |
| Blob      | Last modified UTC |
| Blob      | ETag              |
| Blob      | Length            |
| Blob      | Content type      |

<br />

Call the following method in the main method and implement the method:

```csharp
    blobName = "AvanadeLogo.png";
    ReadContainerAndBlobPropertiesAsync(
        connectionstring,
        container,
        blobName)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **ReadContainerAndBlobPropertiesAsync** method as follow:

    ```csharp
    public static async Task ReadContainerAndBlobPropertiesAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await container.FetchAttributesAsync();
        await blockBlob.FetchAttributesAsync();

        Console.WriteLine($"Properties for container {container.StorageUri.PrimaryUri.ToString()}");
        Console.WriteLine($"\tLast modified UTC: {container.Properties.LastModified.ToString()}");
        Console.WriteLine($"\tETag: {container.Properties.ETag}");
        Console.WriteLine();

        Console.WriteLine($"Properties for blob {blockBlob.StorageUri.PrimaryUri.ToString()}");
        Console.WriteLine($"\tLast modified UTC: {blockBlob.Properties.LastModified.ToString()}");
        Console.WriteLine($"\tETag: {blockBlob.Properties.ETag}");
        Console.WriteLine($"\tLength: {LengthToFileSize(blockBlob.Properties.Length)}");
        Console.WriteLine($"\tContent type: {blockBlob.Properties.ContentType}");
        Console.WriteLine();
    }
    ```

1. Implement the **LengthToFileSize** method as follow:

    ```csharp
    private static string LengthToFileSize(long length)
    {
        string[] units = { "B", "KB", "MB", "GB", "TB" };
        int order = (int)Math.Log(length, 1024);

        string unit = units[order];
        double size = length / Math.Pow(1024, order);

        return String.Format("{0:0.##} {1}", size, unit);
    }
    ```

1. Start debugging the test

    The application should display the following content type: application/octet-stream

</details>

#### Task 3: Set the content type of AvanadeLogo.png to image/png

Call the following method in the main method and implement the method:

```csharp
    SetBlobContentTypeAsync(
        connectionstring,
        container,
        blobName,
        "image/png")
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **SetBlobContentTypeAsync** method as follow:

    ```csharp
    public static async Task SetBlobContentTypeAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        string contentType)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await blockBlob.FetchAttributesAsync();
        blockBlob.Properties.ContentType = contentType;
        await blockBlob.SetPropertiesAsync();
    }
    ```

1. Call the **ReadContainerAndBlobPropertiesAsync** method again after the **SetBlobContentTypeAsync** method call

1. Start debugging the test

    The application should display the following content type: image/png

</details>

## Lab 2: Setting and retrieving metadata

:stopwatch: 10 minutes

#### Task 1: Read all the metadata of the az203-blob-storage container and of the AvanadeLogo.png blob

Call the following method in the main method and implement the method:

```csharp
ReadContainerAndBlobMetadataAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **ReadContainerAndBlobMetadataAsync** method as follow:

    ```csharp
    public static async Task ReadContainerAndBlobMetadataAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await container.FetchAttributesAsync();
        await blockBlob.FetchAttributesAsync();

        Console.WriteLine($"Metadata for container {container.StorageUri.PrimaryUri.ToString()}");
        foreach (var metadataItem in container.Metadata)
        {
            Console.WriteLine("\tKey: {0}", metadataItem.Key);
            Console.WriteLine("\tValue: {0}", metadataItem.Value);
        }
        Console.WriteLine();

        Console.WriteLine($"Metadata for container {blockBlob.StorageUri.PrimaryUri.ToString()}");
        foreach (var metadataItem in blockBlob.Metadata)
        {
            Console.WriteLine("\tKey: {0}", metadataItem.Key);
            Console.WriteLine("\tValue: {0}", metadataItem.Value);
        }
        Console.WriteLine();
    }
    ```

1. Start debugging the test

    The metadata should be empty for both the container and the blob

</details>

#### Task 2: Add the following metadata on the blob

* **Key:** Logo
* **Value:** Avanade

<br />

Call the following method in the main method and implement the method:

```csharp
    AddBlobMetadataAsync(
        connectionstring,
        container,
        blobName,
        "Logo",
        "Avanade")
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **AddBlobMetadataAsync** method as follow:

    ```csharp
    public static async Task AddBlobMetadataAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        string metadataKey,
        string metadataValue)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await blockBlob.FetchAttributesAsync();

        if (blockBlob.Metadata.ContainsKey(metadataKey))
            blockBlob.Metadata.Remove(metadataKey);
        blockBlob.Metadata.Add(metadataKey, metadataValue);

        await blockBlob.SetMetadataAsync();
    }
    ```

1. Call the **ReadContainerAndBlobMetadataAsync** method again after the **AddBlobMetadataAsync** method call

1. Start debugging the test

    The application should display the following content type: image/png

</details>

#### Task 3: In the main method, comment all the calls to the properties and metadata methods