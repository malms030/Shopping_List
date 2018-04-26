<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    public int userid = 0;


    protected void loginButton_Click(object sender, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
        string sqlstmt = "select id from admins where username like '" + Uid.Text + "' and password like '" + UPwd.Text + "';";
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlstmt, sqlConnStr);
        cmd.Connection.Open();
        System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();

        if (reader.Read())
        {
            HttpCookie idcookie = new HttpCookie("UserID");
            HttpCookie hf1cookie = new HttpCookie("hf1");
            HttpCookie hf2cookie = new HttpCookie("hf2");
            idcookie.Value = reader[0].ToString();
            hf1cookie.Value = "1";
            hf2cookie.Value = "1";
            Response.Cookies.Add(idcookie);
            Response.Cookies.Add(hf1cookie);
            Response.Cookies.Add(hf2cookie);
            cmd.Connection.Close();
            Response.Redirect("Admin.aspx");
        }
        else
        {
            cmd.Connection.Close();
            try
            {
                System.Data.SqlClient.SqlConnection sqlConnStr2 = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlstmt2 = "select id from users where username like '" + Uid.Text + "' and password like '" + UPwd.Text + "';";
                System.Data.SqlClient.SqlCommand cmd2 = new System.Data.SqlClient.SqlCommand(sqlstmt2, sqlConnStr2);
                cmd2.Connection.Open();
                System.Data.SqlClient.SqlDataReader reader2 = cmd2.ExecuteReader();

                if (reader2.Read())
                {
                    HttpCookie idcookie = new HttpCookie("UserID");
                    HttpCookie hf1cookie = new HttpCookie("hf1");
                    HttpCookie hf2cookie = new HttpCookie("hf2");
                    idcookie.Value = reader2[0].ToString();
                    hf1cookie.Value = "1";
                    hf2cookie.Value = "1";
                    Response.Cookies.Add(idcookie);
                    Response.Cookies.Add(hf1cookie);
                    Response.Cookies.Add(hf2cookie);
                    cmd2.Connection.Close();
                    Response.Redirect("List.aspx");
                }
                else
                {
                    Uid.BorderColor = System.Drawing.Color.Red;
                    UPwd.BorderColor = System.Drawing.Color.Red;
                    errorlogin.Text = "Username or password invalid";
                }

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Uid.BorderColor = System.Drawing.Color.Red;
                UPwd.BorderColor = System.Drawing.Color.Red;
                errorlogin.Text = "Username or password invalid";
            }
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List Login</title>
     <link rel="stylesheet" type="text/css" href="css/Login.css"/>
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
            <asp:TextBox runat="server" ID="UPwd" placeholder="Enter Password" TextMode="Password" required="required" CssClass="Textbox" />
            <br />
            <asp:label runat="server" ID="errorlogin" Text=" " />
            <br />
            <asp:Button runat="server" ID="loginButton" OnClick="loginButton_Click" Text="Log In" />
            <br />
            <br />
            <br />
            <span>Not a registered user? </span>
            <asp:LinkButton runat="server" ID="createAccountButton" Text="Create an Account" PostBackUrl="createAccount.aspx" /><br />
            <span>Experiencing Problems?</span>
             <asp:LinkButton runat="server" ID="helpButton" Text="Submit a Help Request" PostBackUrl="submitRequest.aspx" />
        </asp:label>
    </form>
    </div>

</body>
</html>