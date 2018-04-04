<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    protected void loginButton_Click(object sender, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
        string sqlstmt = "select * from users where username like '"+Uid.Text +"' and password like '"+UPwd.Text+"';";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlstmt, sqlConnStr);
        cmd.Connection.Open();
        System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

        if (reader.Read())
        {
            Response.Redirect("List.aspx");
        }
        else
        {
            Uid.BorderColor = System.Drawing.Color.Red;
            UPwd.BorderColor = System.Drawing.Color.Red;
        }
        cmd.Connection.Close();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Login</title>
     <link rel="stylesheet" type="text/css" href="Login.css"/>
</head>
<body>
    <div id="loginDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin">
            <b id="loginTitle">Shopping List</b>
            <br />
                    <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
            <span id="spanUid">Username</span>
            <br />
            <asp:TextBox runat="server" ID="Uid" placeholder="Enter Username" required="required" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanPwd">Password</span>
            <br />
            <asp:TextBox runat="server" ID="UPwd" placeholder="Enter Password" required="required" CssClass="Textbox" />
            <br />
            <br />
            <asp:Button runat="server" ID="loginButton" OnClick="loginButton_Click" Text="Log In" />
            <br />
            <br />
            <br />
            <span>Not a registered user? </span>
            <asp:LinkButton runat="server" ID="createAccountButton" Text="Create an Account" PostBackUrl="createAccount.aspx" />
        </asp:label>
    </form>
    </div>

</body>
</html>