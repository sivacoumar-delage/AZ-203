# Create an Azure App Service API app

## Lab 1: Create an API in Visual Studio

:stopwatch: XYZ minutes

#### Task 1: Create an ASP.NET Core Web API solution

<details>
<summary>Click here to display answers</summary>

1. Open **Visual Studio 2017**

1. Click the menu **File** > **New** > **Project...**

1. In the **New Project** dialog, expand **Installed** > **Visual C#** > **Web**, and select **ASP.NET Core Web Application**

1. Next to **Name**, type *TodoApi*

1. Click **OK**

1. In the **New ASP.NET Core Web Application - TodoApi**, ensure that **.NET Core** is select and that the latest version of **ASP.NET Core** is selected as well

1. Select **API**

1. Ensure that **Configure for HTTPS** is checked

1. Click **OK**

</details>

#### Task 2: Add a model class called TodoItem

The class TodoItem should have the following properties:
- a numerical *Id*
- a string *Name*
- a boolean *IsComplete*

<details>
<summary>Click here to display answers</summary>

1. In **Solution Explorer**, right-click the project, select **Add** > **New Folder** and name the folder *Models*

1. Right-click the *Models* folder, select **Add** > **Class**

    > **Note:** Model classes can go anywhere in the project, but the *Models* folder is used by convention.

1. In the **Add New Item - TodoApi**, type *TodoItem* next to **Name** and click **Add**

1. Replace the class with the following code:

    ```csharp
    public class TodoItem
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public bool IsComplete { get; set; }
    }
    ```

</details>

#### Task 3: Add a database context called TodoContext with Entity Framework

<details>
<summary>Click here to display answers</summary>

<!-->
1. In the **Solution Explorer**, right-click the project **TodoApi** and select **Manage Nuget Packages...**

1. In the **Nuget** tab, click **Browse**

1. Search **Microsoft.EntityFrameworkCore** and **Install** the packages

1. In the **License Acceptance** dialog, click **I Accept**

1. Close the **Nuget** tab

1. Right-click the **Models** folder and select **Add** > **Class**

1. In the **Add New Item - TodoApi**, type *TodoContext* next to **Name** and click **Add**
-->

1. In **TodoContext.cs** file, add the following using statements:

    ```csharp
    using Microsoft.EntityFrameworkCore;
    ```

1. In **TodoContext.cs** file, replace the class with the following code:

    ```csharp
    public class TodoContext : DbContext
    {
        public TodoContext(DbContextOptions<TodoContext> options)
            : base(options)
        {
        }

        public DbSet<TodoItem> TodoItems { get; set; }
    }
    ```
    
</details>

#### Task 4: Register the database context with in-memory database

<details>
<summary>Click here to display answers</summary>

1. In the **Solution Explorer**, open the **Startup.cs** file

1. In **Startup.cs** file, add the following using statements:

    ```csharp
    using Microsoft.EntityFrameworkCore;
    using TodoApi.Models;
    ```

1. In **Startup.cs** file, add the following code in the method **ConfigureServices**

    ```csharp
    services.AddDbContext<TodoContext>(opt =>
        opt.UseInMemoryDatabase("TodoList"));
    ```

</details>

#### Task 5: Add a controller called TodoController

<details>
<summary>Click here to display answers</summary>

<!--
1. In the **Solution Explorer**, right-click te **Controllers** folder, and select **Add** > **Controller...**

1. In the **Add Scaffold** dialog, select **API Controller with actions, using Entity Framework**

1. In the **Add API Controller with actions, using Entity Framework** dialog, type *TodoController* next to **Controller name**

1. Next to **Model class**, select *TodoItem (TodoApi.Models)*

1. Next to **Data context class**, select *TodoContext (TodoApi.Models)*

1. Click **Add**
-->



</details>

#### Task 6: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 7: aaa

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 2: Deploy the API in Azure

:stopwatch: XYZ minutes

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