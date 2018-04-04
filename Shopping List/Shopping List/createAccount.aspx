<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void logInButton_Click(object sender, EventArgs e)
    {
        if (createUPwd.Text == confirmPWD.Text)
        {
            System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
            string sqlinsert = "insert into users(username,password) values (@uid, @pwd)";
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
            cmd.Parameters.Add("@uid", System.Data.SqlDbType.VarChar, 50);
            cmd.Parameters["@uid"].Value = createUid.Text;
            cmd.Parameters.Add("@pwd", System.Data.SqlDbType.VarChar, 50);
            cmd.Parameters["@pwd"].Value = confirmPWD.Text;
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            Response.Redirect("Default.aspx");
            cmd.Connection.Close();
        }
        else
        {
            createUPwd.BorderColor = System.Drawing.Color.Red;
            confirmPWD.BorderColor = System.Drawing.Color.Red;
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Create Account</title>
     <link rel="stylesheet" type="text/css" href="Login.css"/>
</head>
<body>
    <div id="createAccDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin">
            <b id="loginTitle">Create an Account</b>
            <br />
                    <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
            <span id="spanUid">Create a Username</span>
            <br />
            <asp:TextBox runat="server" ID="createUid" placeholder="Enter Username" required="required" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanPwd">Create a Password</span>
            <br />
            <asp:TextBox runat="server" ID="createUPwd" placeholder="Enter Password" required="required" TextMode="Password" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanPwd2">Confirm Password</span>
            <br />
            <asp:TextBox runat="server" ID="confirmPWD" placeholder="Confirm Password" required="required" TextMode="Password" CssClass="Textbox" />
            <br />
            <br />
            <asp:Button runat="server" ID="createButton" Text="Create Account" onClick="logInButton_Click"/>
            <br />
            <br />
            <br />
            <span>Already a registered user? </span>
            <asp:LinkButton runat="server" ID="logInButton" Text="Login" PostBackURL="Login.aspx" />
        </asp:label>
    </form>
    </div>

</body>
</html>