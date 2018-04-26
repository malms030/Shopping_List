<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    public void submitButton_Click (object sender, EventArgs e)
    {
        if (emailBox.Text.Contains("@") && !(emailBox.Text == "") && !(Content.Text == ""))
        {
            try
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlinsert = "insert into help_requests (status, type, email, phone_number, details) values (@status, @type, @email, @phone_number, @details);";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
                cmd.Parameters.AddWithValue("@status", "NEW");
                cmd.Parameters.AddWithValue("@type", type.Text);
                cmd.Parameters.AddWithValue("@email", emailBox.Text);
                cmd.Parameters.AddWithValue("@phone_number", TextBox1.Text);
                cmd.Parameters.AddWithValue("@details", Content.Text);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                Response.Redirect("Login.aspx");

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
            }
        }
        else {
            emailBox.BorderColor = System.Drawing.Color.Red;
            Content.BorderColor = System.Drawing.Color.Red;
        }
    }
    public void cancel_Click (object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
</script>
<%--<script type="text/javascript">
    function myFunction() {
        document.getElementById("myDropdown").classList.toggle("show");
    }

    function myFunction2() {
        document.getElementById("myDropdown2").classList.toggle("show");
    }

    // Close the dropdown if the user clicks outside of it
    window.onclick = function (event) {
        if (!event.target.matches('.dropbtn')) {

            var dropdowns = document.getElementsByClassName("dropdown-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.classList.contains('show')) {
                    openDropdown.classList.remove('show');
                }
            }
        }
    }--%>

<%--</script>--%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Submit a Help Request</title>
     <link rel="stylesheet" type="text/css" href="css/submitRequest.css"/>
     <link rel="stylesheet" type="text/css" href="css/List.css"/>
    <%--<style>
        .dropdown {
    position: relative;
    display: inline-block;
}

.dropdown2 {
    position: absolute;
    padding-left: 358px;
    padding-top: 20px;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: saddlebrown;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: white;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown a:hover {background-color: #FFFAF0; color: black;
}
.dropdown2 a:hover {background-color: #FFFAF0; color: black;
}

.show {display:block;}

    </style>--%>
</head>
<body>

    <%-- <div id="icons">
 
<img id="userBtn" src="Images/usericon.png" class="dropbtn" onclick="myFunction2()" />
<div class="dropdown">
  <div id="myDropdown2" class="dropdown-content" style="left:-40px; top:25px">
    <a href="#home">Update User Information</a>
    <a href="Login.aspx">Sign Out</a>
  </div>
</div>           


<img id="settingsBtn" src="Images/settings.png" class="dropbtn" onclick="myFunction()" />
<div class="dropdown2">
  <div id="myDropdown" class="dropdown-content" style=" right: -20px; top:40px">
    <a href="submitRequest.aspx">Submit Help Request</a>
    <a href="storeLocator.html">Store Locator</a>
  </div>
</div>
           <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
           <br />
       </div>--%>


    <div id="requestDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin">
           <br />
            <span id="spanSubject">Select an Issue Type</span>
            <br />
            <asp:DropDownList ID="type" runat="server">
                <asp:ListItem Text="Applicatin Behavior" Value="1"></asp:ListItem>
                <asp:ListItem Text="User Account" Value="2"></asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <span id="spanemail">Email</span>
            <br />
            <asp:TextBox runat="server" ID="emailBox" placeholder="Email where we can reach you"  CssClass="subject" />
            <br />
            <br />
            <span id="spanphone">Phone Number</span>
            <br />
            <asp:TextBox runat="server" ID="TextBox1" placeholder="Optional"  CssClass="subject" />
            <br />
            <br />
            <span id="spanContent">Details</span>
            <br />
            <asp:TextBox runat="server" ID="Content"  textmode="MultiLine" CssClass="content" />
            <br />
            <asp:Button runat="server" ID="reqSubmitButton" OnClick="submitButton_Click" Text="Submit" style="margin-right:8px" />
            <asp:Button runat="server" ID="cancel" OnClick="cancel_Click" Text="Cancel" />
            <br />

        </asp:label>
    </form>
    </div>

</body>
</html>