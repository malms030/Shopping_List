<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    void Page_Load()
    {
        try
        {
            if (Session.IsNewSession)
            {
                Response.Redirect("Login.aspx");
            }
            else if (Session["isAuthenticatedAdmin"].ToString() == "yes")
            {
                form1.Visible = true;
            }
            else if (Session["isAuthenticatedAdmin"].ToString() == "no" || Session["isAuthenticatedAdmin"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }catch(System.NullReferenceException ex)
        {
            Response.Redirect("Login.aspx");
        }
    }

    public void logout(object o, EventArgs e)
    {
         Session["isAuthenticatedAdmin"] = "no";
        Response.Redirect("Login.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/Admin.css"/>
<style>
.dropbtn {
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: floralwhite;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: #f1f1f1}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    
}

        #adminTitle {
            font-size: 28px;
            font: bold;
            font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
            padding-right:820px;
        }
</style>
</head>

<body>
    <form id="form1" visible="false" runat="server">
    <div id ="AdminView">
    <div class="dropdown" style="float:right;">
  <img id="userBtn" class="dropbtn"src="Images/usericon.png" />
  <div class="dropdown-content" style="margin-top:70px;">
    <asp:LinkButton ID="about" OnClick="logout" text="Sign Out" runat="server" />
  </div>
            
        </div>
        <br \ />
            <br \ />
            <br \ />
            <br \ />
            <br \ />
        <div id ="grid">
            <asp:GridView
                id="helpRequests"
                DataSourceID="requests"
                DataKeyNames ="id"
                AutoGenerateEditButton="true"
                CellPadding="10" 
                border="0"
                GridLines="Horizontal"
                AllowSorting="True"
                Runat="server">
                <HeaderStyle CssClass="GridHeadertext" />

               <%-- <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID ="rowbtn" Text="Edit" onClick="rowbtn_Click" DataKeyNames="id" style=" background-color: saddlebrown;color: white;padding: 5px 5px;
                            border: none;cursor: pointer;font-size: 12px;" runat="server"/>
                        </ItemTemplate>
                    </asp:TemplateField>
             </Columns>--%>
            </asp:GridView>
            <asp:SqlDataSource
                id="requests"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT id as ID, status as Status, email as Email, phone_number as Phone#, details as Details, comments as Comments, CONVERT(VARCHAR(12), date_opened, 107) 'Date' from help_requests where status not like 'Closed';"
                UpdateCommand="Update help_requests set status=@Status, email=@Email, phone_number=@Phone#, details=@Details, comments=@comments where id=@id;"
                Runat="server">
            </asp:SqlDataSource>
        </div>
        </div>
        <br \ />

    </form>
</body>
</html>
