# Manage snapshots of a Blob

## Lab 1: Creating a snapshot of a Blob

:stopwatch: 5 minutes

#### Task 1: Open the solution BlobStorageSample in Visual Studio

#### Task 2: In the main method, comment the call to the ListFilesFromBlobStorageAsync, ReadFilesAsync, DownloadFilesAsync methods

#### Task 3: List all the snapshots of the blob "Alpha.txt"

Call the following method in the main method and implement the method:

```csharp
blobName = "Alpha.txt";

ListBlobSnapshotsAsync(
    connectionstring,
    container,
    blobName)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    private static async Task ListBlobSnapshotsAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);

        var resultSegment = await container.ListBlobsSegmentedAsync(
            null, 
            true, 
            BlobListingDetails.Snapshots, 
            null, 
            null, 
            null, 
            null);

        var snapshots = resultSegment
            .Results
            .Cast<CloudBlockBlob>()
            .Where(blob => blob.IsSnapshot && blob.Name == blobName);

        foreach (var snapshot in snapshots)
            Console.WriteLine($"Snapshot of {snapshot.Name} taken at date: {snapshot.SnapshotTime.Value.ToLocalTime()}.");
    }
    ```

1. Start debugging to check that there is no snapshot of the *Alpha.txt* blob

</details>

#### Task 4: Make a snapshot

Call the following method in the main method and implement the method:

```csharp
var snapshot = CreateBlobSnapshotAsync(
    connectionstring,
    container,
    blobName)
    .GetAwaiter()
    .GetResult();
Console.WriteLine($"Snapshot taken for the blob {snapshot.Name}");
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    private static async Task<CloudBlob> CreateBlobSnapshotAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlob blob = container.GetBlobReference(blobName);

        CloudBlob snapshot = await blob.SnapshotAsync();

        return snapshot;
    }
    ```

1. In the main method, call the **ListBlobSnapshotsAsync** method again after the completion of the **CreateBlobSnapshotAsync** method

1. Start debugging to check that the snapshot has been successfully created

</details>

## Lab 2: Read the latest snapshot of the Alpha.txt blob

:stopwatch: 10 minutes

#### Task 1: In the main method, comment the CreateBlobSnapshotAsync method call and the ListBlobSnapshotsAsync method calls

#### Task 2: Read the latest snapshot of the Alpha.txt blob

Call the following method in the main method and implement the method:

```csharp
ReadLatestBlobSnapshotAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    public static async Task ReadLatestBlobSnapshotAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);

        var resultSegment = await container.ListBlobsSegmentedAsync(
            null,
            true,
            BlobListingDetails.Snapshots,
            null,
            null,
            null,
            null);

        var snapshots = resultSegment
            .Results
            .Cast<CloudBlockBlob>()
            .Where(blob => blob.IsSnapshot && blob.Name == blobName);

        var snapshot = snapshots
            .First(blob => 
            blob.SnapshotTime == 
            snapshots.Max(max => max.SnapshotTime));

        await ReadBlobContentAsync(container, snapshot);
    }
    ```

1. In the **ReadBlobContentAsync** method, change the call to the GetBlobReference method in order to include the snapshot time

    ```csharp
    ```

1. 

</details>

#### Task 3: Update the Alpha.txt blob content to Delta

Call the following method in the main method and implement the method:

```csharp
UpdateBlobContentAsync(
    connectionstring,
    container,
    blobName,
    "Delta")
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    public static async Task UpdateBlobContentAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        string newValue)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await blockBlob.UploadTextAsync(newValue);
    }
    ```

</details>

#### Task 4: Read the Alpha.txt blob content then read the snapshot content

<details>
<summary>Click here to display answers</summary>

1. Call the **ReadFilesAsync** method after the completion the **UpdateBlobContentAsync**

1. Call the **ReadLatestBlobSnapshotAsync** method after the completion the **ReadFilesAsync**

</details>

#### Task 5: Start debugging to check the blob and snapshot content

## Lab 3: Restore a snapshot

:stopwatch: 5 minutes

#### Task 1: Restore the latest snapshot

Call the following method in the main method and implement the method:

```csharp
RestoreLatestBlobSnapshotAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    public static async Task RestoreLatestBlobSnapshotAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        var resultSegment = await container.ListBlobsSegmentedAsync(
            null,
            true,
            BlobListingDetails.Snapshots,
            null,
            null,
            null,
            null);

        var snapshots = resultSegment
            .Results
            .Cast<CloudBlockBlob>()
            .Where(blob => blob.IsSnapshot && blob.Name == blobName);

        var snapshot = snapshots
            .First(blob =>
            blob.SnapshotTime ==
            snapshots.Max(max => max.SnapshotTime));

        await blockBlob.StartCopyAsync(snapshot);
    }
    ```

</details>

#### Task 2: Read the Alpha.txt blob content after snapshot restoration

#### Task 3: Start debugging to check the blob content

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 4: Deleting snapshots

:stopwatch: 10 minutes

#### Task 1: Delete all Alpha.txt snapshots

Call the following method in the main method and implement the method:

```csharp
DeleteAllBlobSnapshotsAsync(
    connectionstring,
    container,
    blobName)
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    private static async Task DeleteAllBlobSnapshotsAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);

        var resultSegment = await container.ListBlobsSegmentedAsync(
            null,
            true,
            BlobListingDetails.Snapshots,
            null,
            null,
            null,
            null);

        var snapshots = resultSegment
            .Results
            .Cast<CloudBlockBlob>()
            .Where(blob => blob.IsSnapshot && blob.Name == blobName);

        foreach (var snapshot in snapshots)
            await snapshot.DeleteIfExistsAsync();
    }
    ```

</details>

#### Task 2: Call the ListBlobSnapshotsAsync method to check that all the Alpha.txt blob' snapshots have been deleted

#### Task 3: In the main method, comment all the snapshots methods calls