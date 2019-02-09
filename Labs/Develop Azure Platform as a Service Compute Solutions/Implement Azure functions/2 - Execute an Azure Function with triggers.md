# Execute an Azure Function with triggers

## Lab 1: …by using data operations

#### Task 1: Create a Function Apps named az203functions-Portal-XXXXX

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **App Services**

1. Click on the button **Add**

1. In the **Marketplace** blade, click **Function App**

1. Click **Create**

1. In the **Function App** blade, under **App name**, replace XXXXX by a unique name and type *az203functions-Portal-XXXXX*

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

</details>

#### Task 2: Create and test a Queue storage in Azure

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in a previous lab

1. In the **Storage account** blade, click **Queues** in the menu

1. In the **Queues** blade, click on the button **Queue** in order to add a new queue

1. In the **Add queue** dialog, under **Queue name**, type *profile-picture-url-queue*

1. In the **Queues** blade, click *profile-picture-url-queue*

1. In the *profile-picture-url-queue* blade, click on the button **Add message**

1. In the **Add message to queue** dialog, under **Message text**, type *Alpha*

1. Click **OK**

1. Repeat the last two steps to add the messages *Beta* and *Omega*

1. In the *profile-picture-url-queue* blade, check that the messages has been added to the queue

1. Select the message *Beta*

1. Click on the button **Dequeue message**

1. In the **Dequeue first message** dialog, click **Yes**

    The message *Alpha* will be removed from the queue. 
    
    > **Note:** A queue is first in, first-out.

1. Click on the button **Clear queue**

1. In the **Dequeue all messages** dialog, click **Yes**

    All the messages should be removed from the queue.

</details>

#### Task 3: Create a function with Queue storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Go to the *az203functions-Portal-XXXXX* **Function App** 

1. Click **Functions**

1. Click **New function**

1. Select **Azure Queue Storage trigger**

1. In the **Extensions not Installed** dialog, click **Install**

1. In the **Extensions Installation Succeeded** dialog, click **Continue**

1. In the **New Function** dialog, under **Name**, type *DownloadPictureFromUrl*

1. Under **Queue name**, type *profile-picture-url-queue*

1. Under **Storage account connection**, click **new**

1. In the **Storage Account** blade, select *az203storageaccountXXXXX*

1. Click **Create**

</details>

#### Task 4: Test the function with Queue storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a new tab and navigate to [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts** and select *az203storageaccountXXXXX*

1. Click **Queues** and select *profile-picture-url-queue*

1. Go back in the tab with the *DownloadPictureFromUrl* blade, click **Run**

    The **Request body** displays the message sent to the queue. The **Logs** displays the information with the message content.

1. Update the **Request body** with the message *testfromFunctionApp* and click **Run**

    The **Logs** should display "C# Queue trigger function processed: testfromFunctionApp"

1. Go to the other tab with the **Queue Storage** blade, and click **Add message**

1. In the **Add message to queue** dialog, under **Message text**, type *testFromQueue*, and click **OK**

1. Click **Refresh**

1. Go back to the tab with the *DownloadPictureFromUrl* blade, check the **Logs**

    The **Logs** should display "C# Queue trigger function processed: testFromQueue"

</details>

#### Task 5: Create and test a Queue storage locally in Azure Storage Explorer

<details>
<summary>Click here to display answers</summary>

1. Start **Microsoft Azure Storage Explorer**

1. Expand **Local & Attached** > **Storage Accounts** > **Emulator - Default Ports (Key)**

1. Right-click **Queues** and select **Create Queue**

1. Type *profile-picture-url-queue*

1. In the *profile-picture-url-queue* tab, click on the button **Add Message**

1. In the **Microsoft Azure Storage Explorer - Add Message** dialog, under **Message text**, type *Alpha*

1. Click **OK**

1. Repeat the last two steps to add the messages *Beta* and *Omega*

1. In the *profile-picture-url-queue* tab, check that the messages has been added to the queue

1. Select the message *Beta*

1. Click on the button **Dequeue Message**

1. In the pop-up dialog, click **Yes**

    The message *Alpha* will be removed from the queue. 
    
    > **Note:** A queue is first in, first-out.

1. Click on the button **Clear Queue**

1. In the pop-up dialog, click **Yes**

    All the messages should be removed from the queue.

1. Click on **Emulator - Default Ports (Key)**

1. In the bottom left, copy and save the **Primary Connection String** value

</details>

#### Task 6: Create a function with Queue storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Start **Visual Studio 2017** and open the *az203functions* solution

1. In the **Solution Explorer**, right-click the *az203functions* project and select **Add** > **New Azure Function...**

1. In the **Add New Item - az203functions** dialog, under **Name**, type *DownloadPictureFromUrl*

1. Click **Add**

1. In the **New Azure Function - DownloadPictureFromUrl** dialog, select **Queue trigger**

1. Under **Connection string setting**, type *az203storageaccountXXXXX_STORAGE*

1. Under **Queue name**, type *profile-picture-url-queue*

1. Click **OK**

    A new file called *DownloadPictureFromUrl.cs* should be created. an error indicates that the **QueueTrigger** attribute could not be found.

1. In the **Solution Explorer**, right-click the *az203functions* project and select**Manage NuGet Packages...**

1. In the **NuGet** tab, click **Browse**

1. Search *Microsoft.Azure.WebJobs.Extensions.Storage*, and select **Microsoft.Azure.WebJobs.Extensions.Storage**

1. Click **Install**, and in the **License Acceptance** dialog, click **I Accept**

1. Close the **NuGet** tab
    
    In the *DownloadPictureFromUrl.cs* file, the **QueueTrigger** attribute sould be resolved.

1. In the **Solution Explorer**, open the **local.settings.json**

1. In the **View** menu, open **Cloud Explorer**, expand **(Local)** > **Storage Accounts** > **(Development) (Key)**, then select Properties and copy the Primary Connection String value.

1. In the **local.settings.json** file, under **Values** section, add a setting called *az203storageaccountXXXXX_STORAGE* and paste the **Primary Connection String** copied during the previous task

</details>

#### Task 7: Test the function with Queue storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Click the **Debug** menu, and select **Start Debugging**

    > **Warning!** If an exception is raised, make sure that the time displayed in the console matches the one on your local machine. If not, adjust the time in your computer (usually **(UTC) Coordinated Universal Time**)

1. Go back to **Microsoft Azure Storage Explorer**, select the queue *profile-picture-url-queue* and add a message with the text *testFromLocal*

    The message should be added to the queue

1. Click the **Refresh** button

    The queue should be empty

1. Go back to the Azure functions console

    *C# Queue trigger function processed: testFromLocal* should be displayed in the **Logs**

1. In **Visual Studio**, click the **Debug** menu, and select **Stop Debugging**

</details>

#### Task 8: Create a Blob storage in Azure

<details>
<summary>Click here to display answers</summary>

1. Create three text files named *Alpha*, *Beta*, and *Omega* on your computer

1. Open each file, and type the name of the file in the content

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in a previous lab

1. In the **Storage account** blade, click **Blobs** in the menu

1. In the **Blobs** blade, click on the button **Container** in order to add a new blob storage

1. In the **New container** dialog, under **Name**, type *raw-profile-pictures*

1. Under **Public access level**, select **Blob (anonymous read access for blobs only)**

1. Click **OK**

1. In the **Blobs** blade, click *raw-profile-pictures*

1. In the *raw-profile-pictures* blade, click on the button **Upload**

1. In the **Upload blob** dialog, under **Files**, click **Select a file**

1. Browse and select the first text file *Alpha*

1. Expand **Advanced**

1. Under **Blob type**, select **Block blob**

    > **Note:** [Click here to consult the documentation to understand Block Blobs, Append Blobs, and Page Blobs](https://docs.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs)

1. Click **Upload**

1. Repeat the last six steps to upload the files *Beta* and *Omega*

1. In the *raw-profile-pictures* blade, check that the files has been uploaded in the storage

1. Select the file *Beta.txt*

1. Copy the **URL** of the file

1. In the web browser, open a new tab, paste the **URL** and navigate to the blob

    The content of the text file should be displayed: *Beta*.

1. Close the tab

1. In **Azure Portal**, go back to the *raw-profile-pictures* blade

1. In the *raw-profile-pictures* blade, click on the button **Upload**

1. In the **Upload blob** dialog, under **Files**, click **Select a file**

1. In **File name**, type *https://www.avanade.com/~/media/logo/avanade-logo.svg* and click **Open**

1. Expand **Advanced**

1. Under **Blob type**, select **Block blob**

    > **Note:** [Click here to consult the documentation to understand Block Blobs, Append Blobs, and Page Blobs](https://docs.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs)

1. Click **Upload**

1. In the *raw-profile-pictures* blade, check that the picture has been uploaded in the storage

1. Select the file *avanade-logo\[1].svg*

1. Copy the **URL** of the file

1. In the web browser, open a new tab, paste the **URL** and navigate to the blob

    The picture should be displayed.

1. Close the tab

1. Select all files

1. Click **Delete**

1. In the **Delete blob(s)** dialog, click **OK**

</details>

#### Task 9: Create a function with Blob storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Go to the *az203functions-Portal-XXXXX* **Function App** 

1. Click **Functions**

1. Click **New function**

1. Select **Azure Blob Storage trigger**

1. In the **New Function** dialog, under **Name**, type *ResizePicture*

1. Under **Path**, type *raw-profile-pictures/{name}*

1. Under **Storage account connection**, click **new**

1. In the **Storage Account** blade, select *az203storageaccountXXXXX*

1. Click **Create**

</details>

#### Task 10: Test the function with Blob storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a new tab and navigate to [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts** and select *az203storageaccountXXXXX*

1. Click **Blobs** and select *raw-profile-pictures*

1. Go back in the tab with the *ResizePicture* blade, click **Logs**

1. Go to the tab with the **Blob Storage** blade, click on the button **Upload**

1. In the **Upload blob** dialog, under **Files**, click **Select a file**

1. In **File name**, type *https://www.avanade.com/~/media/logo/avanade-logo.svg* and click **Open**

1. Click **Upload**

1. Close the **Upload blob** dialog

1. Go back to the tab with the *ResizePicture* blade, check the **Logs**

    The **Logs** should display "C# Blob trigger function Processed blob Name:avanade-logo[1].svg"

1. Go to the tab with the **Blob Storage** blade, click on the button **Refresh**

    The picture should remain in the storage.

</details>

#### Task 11: Create a Blob storage locally in Azure Storage Explorer

<details>
<summary>Click here to display answers</summary>

1. Start **Microsoft Azure Storage Explorer**

1. Expand **Local & Attached** > **Storage Accounts** > **Emulator - Default Ports (Key)**

1. Right-click **Blob Containers** and select **Create Blob Container**

1. Type *raw-profile-pictures*

1. In the *raw-profile-pictures* tab, click on the button **Upload**, then select **Upload Files...**

1. In the **Microsoft Azure Storage Explorer - Upload Files** dialog, under **Files**, click **No files selected**

1. Browse and select the three files *Alpha*, *Beta* and *Omega*

1. Click **Upload**

1. In the *raw-profile-pictures* tab, check that the files has been uploaded in the storage

1. Select the file *Beta*

1. Click on the button **Open**

    The file will be opened.

1. Close the file

1. Select all files in the **Blob storage**

1. Click on the button **More** > **Delete**

1. In the pop-up dialog, click **Delete**

1. In the notification on the top, click **Yes** in order to refresh the storage view

    All the files should be deleted from the storage.

</details>

#### Task 12: Create a function with Blob storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Go to **Visual Studio 2017** instance with the *az203functions* solution

1. In the **Solution Explorer**, right-click the *az203functions* project and select **Add** > **New Azure Function...**

1. In the **Add New Item - az203functions** dialog, under **Name**, type *ResizePicture*

1. Click **Add**

1. In the **New Azure Function - ResizePicture** dialog, select **Blob trigger**

1. Under **Connection string setting**, type *az203storageaccountXXXXX_STORAGE*

1. Under **Path**, type *raw-profile-pictures*

1. Click **OK**

</details>

#### Task 13: Test the function with Blob storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Click the **Debug** menu, and select **Start Debugging**

1. Go back to **Microsoft Azure Storage Explorer**, select the **Blob Container** *raw-profile-pictures* and upload the picture located in *https://www.avanade.com/~/media/logo/avanade-logo.svg*

    The file should be added to the storage.

1. Go back to the Azure functions console

    *C# Blob trigger function Processed blob<br />Name:avanade-logo[1].svg* should be displayed in the **Logs**

1. In **Visual Studio**, click the **Debug** menu, and select **Stop Debugging**

</details>

## Lab 2: …by timers

#### Task 1: Create a function with Timer trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Test the function with Timer trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: Create a function with Timer trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 4: Test the function with Timer trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 3: …by webhooks

#### Task 1: Create and configure a GitHub webhook

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Create a function with GitHub webhook trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: Test the function with GitHub webhook trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>