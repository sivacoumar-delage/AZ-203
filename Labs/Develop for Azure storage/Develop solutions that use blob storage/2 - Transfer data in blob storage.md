# Transfer data in blob storage

## Lab 1: Upload files from .NET application 

:stopwatch: 5 minutes

#### Task 1: Prepare an image to upload

<details>
<summary>Click here to display answers</summary>

1. Open a web browser and go to [https://upload.wikimedia.org/wikipedia/en/thumb/3/3a/Avanade_logo17.png/250px-Avanade_logo17.png](https://upload.wikimedia.org/wikipedia/en/thumb/3/3a/Avanade_logo17.png/250px-Avanade_logo17.png)

1. Download the image on your computer

</details>

#### Task 2: Get the connection string of the az203storageaccountXXXXX storage account

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in the previous lab

1. In the **Storage account** blade, click **Access keys** in the menu

1. In the **Access keys** blade, copy the **Connection string** of the master key

</details>

#### Task 3: Create a .NET Core console application

<details>
<summary>Click here to display answers</summary>

1. Open **Visual Studio**

1. Click the menu **File** > **New** > **Project...**

1. In the **New Project** window, expand **Visual C#** and select **.NET Core**, then select **Console App (.NET Core)**

1. Next to **Name**, type *BlobStorageSample*

1. Click **OK**

</details>

#### Task 4: Create an App.config file and add the storage account connection string

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, right-click the *BlobStorageSample* project and select **Add** > **New Item...**

1. In the **Add New Item - BlobStorageSample** window, select **JSON File**

1. Next to **Name**, type *appsettings.json*

1. Click **Add**

1. Open the *appsettings.json* file

1. Add the *ConnectionStrings* section

1. Add *Storage* and paste the connection string

1. In the **Solution Explorer**, right-click the *appsettings.json* file, displays the **Properties**

1. In the **Properties**, next to **Copy to Output Directory** select **Copy always**

</details>

#### Task 5: Add the Microsoft.Extensions.Configuration.Json NuGet package

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, right-click the *BlobStorageSample* project and select **Manage NuGet Packages...**

1. In **NuGet: BlobStorageSample**, select the **Browse** tab

1. Search and select *Microsoft.Extensions.Configuration.Json*

1. Click **Install**

1. In the **License Acceptance** popup, click **I Accept**

1. Close **NuGet: BlobStorageSample**

</details>

#### Task 6: Read the blob storage connection string from the configuration file

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

#### Task 7: Add the WindowsAzure.Storage NuGet package

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, right-click the *BlobStorageSample* project and select **Manage NuGet Packages...**

1. In **NuGet: BlobStorageSample**, select the **Browse** tab

1. Search and select *WindowsAzure.Storage*

1. Click **Install**

1. In the **License Acceptance** popup, click **I Accept**

1. Close **NuGet: BlobStorageSample**

</details>

#### Task 8: Create and use the UploadFileToStorage function with the following signature

```csharp
public static async Task<bool> UploadFileToBlobStorageAsync(
    string filePath,
    string storageAccountConnectionString,
    string blobContainer,
    string blobName
)
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **UploadFileToBlobStorageAsync** method as below:

    ```csharp
    public static async Task<bool> UploadFileToBlobStorageAsync(
        string filePath,
        string storageAccountConnectionString,
        string blobContainer,
        string blobName
    )
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        using (var fileStream = File.Open(filePath, FileMode.Open))
        {
            await blockBlob.UploadFromStreamAsync(fileStream);
        }

        return await Task.FromResult(true);
    }
    ```

1. In the **Main** method, replace *XXXXX* with the image file path and add the following code:

    ```csharp
    UploadFileToBlobStorageAsync(
        XXXXX,
        connectionstring,
        "az203-blob-storage",
        "AvanadeLogo.png")
        .GetAwaiter()
        .GetResult();
    ```

</details>

#### Task 9: Test the upload

<details>
<summary>Click here to display answers</summary>

1. Click the menu **Debug** > **Start Debugging** to start debugging the solution

1. After completion, check the blob storage from **Azure Portal** or from **Microsoft Azure Storage Explorer**

</details>

## Lab 2: Upload files with AzCopy

:stopwatch: 5 minutes

#### Task 1: Prepare three text files on your computer

<details>
<summary>Click here to display answers</summary>

1. Create a folder called *Temp* on *C:\\*

1. Create a subfolder called *FilesToUpload* in the *C:\Temp* folder

1. In the *FilesToUpload* folder, create a new text file called *Alpha.txt*, and write Alpha in the file

1. In the *FilesToUpload* folder, create a new text file called *Beta.txt*, and write Beta in the file

1. In the *FilesToUpload* folder, create a new text file called *Omega.txt*, and write Omega in the file

</details>

#### Task 2: Download the latest version of AzCopy

<details>
<summary>Click here to display answers</summary>

* [Windows](https://aka.ms/downloadazcopy-v10-windows

* [Linux](https://aka.ms/downloadazcopy-v10-linux)

* [MacOS](https://aka.ms/downloadazcopy-v10-mac)

</details>

#### Task 3: Open a command-line application and browse to the folder where azcopy.exe is located

#### Task 4: Display the list of available commands

<details>
<summary>Click here to display answers</summary>

1. Launch the following command:

    ```bat
    .\azcopy --help
    ```

</details>

#### Task 5: Create a storage account called az203azcopyXXXXX from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Create a resource**

1. In the **Azure Marketplace**, select **Storage**, then select **Storage account**

1. Next to **Subscription**, select a valid and active subscription

1. Next to **Resource group**, click **Create new**

1. In the popup, under **Name**, type *az203-rg*, then click **OK**

1. Next to **Storage account name**, type *az203azcopyXXXXX* (replace XXXXX by a unique name)

1. Next to **Location**, select the location nearest to your location

1. Next to **Performance**, check **Standard**

1. Next to **Account kind**, select **StorageV2 (general purpose v2)**

1. Next to **Replication**, select **Read-access-geo-redundant storage (RA-GRS)**

1. Next to **Access tier (default)**, select **Hot**

1. Click **Review + create**

1. After completion of validation, click **Create**s

</details>

#### Task 6: Generate a SAS token

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, in the *az203azcopyXXXXX* blade, click  **Shared access signature**

1. Click the **Generate SAS connection string** button

1. Copy the **SAS token**

</details>

#### Task 7: Create a blob container called my-first-container with AzCopy

<details>
<summary>Click here to display answers</summary>

1. Prepare the command by replacing XXXXX with the unique name, and by adding the SAS token at the end of the URL

    ```bat
    .\azcopy make "https://az203azcopyXXXXX.blob.core.windows.net/my-first-container"
    ```

1. Launch the command

    The following message should appear:
    ```text
    Successfully created the resource.
    ```

</details>

1. In **Azure Portal**, in the *az203azcopyXXXXX* blade, click **Blobs** and check that the *my-first-container* has been created

#### Task 8: Upload files from C:\Temp\FilesToUpload to my-first-container with AzCopy

<details>
<summary>Click here to display answers</summary>

1. Prepare the command by replacing XXXXX with the unique name, and by adding the SAS token at the end of the URL

    ```bat
    .\azcopy copy "C:\Temp\FilesToUpload\*.txt" "https://az203azcopyXXXXX.blob.core.windows.net/my-first-container"
    ```

1. Launch the command

1. In **Azure Portal**, go to the *my-first-container*, and check that the files have been uploaded

</details>

## Lab 3: Copy items in blob storage between containers

:stopwatch: 10 minutes

#### Task 1: Create a blob container called my-second-container with AzCopy

#### Task 2: Copy items in blob storage from my-first-container to my-second-container with AzCopy

<details>
<summary>Click here to display answers</summary>

1. Prepare the command by replacing XXXXX with the unique name, and by adding the SAS token at the end of both URLs

    ```bat
    .\azcopy copy "https://az203azcopyXXXXX.blob.core.windows.net/my-first-container" "https://az203azcopyXXXXX.blob.core.windows.net/my-second-container" --recursive=true
    ```

1. Launch the command

1. In **Azure Portal**, go to the *my-second-container*, and check that the files have been uploaded

</details>

## Lab 4: Copy items in blob storage between storage accounts

:stopwatch: 10 minutes

#### Task 1: Generate a SAS token in az203storageaccountXXXXX storage account

#### Task 2: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Prepare the command by replacing XXXXX with the unique name, and by adding the proper SAS token at the end of both URLs

    ```bat
    .\azcopy copy "https://az203azcopyXXXXX.blob.core.windows.net/my-first-container" "https://az203storageaccountXXXXX.blob.core.windows.net/az203-blob-storage" --recursive=true
    ```

1. Launch the command

1. In **Azure Portal**, go to the *az203-blob-storage* container, and check that the files have been uploaded

</details>