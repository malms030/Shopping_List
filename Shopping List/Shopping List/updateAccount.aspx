<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    void Page_Load()
    {
        if (!(IsPostBack))
        {
            System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
            string userid = Request.Cookies["UserID"].Value;
            string sqlselect = "Select firstname,lastname,email,password from users where id = " + userid + ";";
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlselect, sqlConnStr);
            cmd.Connection.Open();
            System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {

                fName.Text = reader.GetString(0);
                lName.Text = reader.GetString(1);
                email.Text = reader.GetString(2);

            }
            cmd.Connection.Close();
        }
    }
    protected void logInButton_Click(object sender, EventArgs e)
    {

        try
        {
            if ((createUPwd.Text == confirmPWD.Text) && (email.Text.Contains("@")))
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlUpdate = "UPDATE USERS SET users.firstname= '" + fName.Text + "', users.lastname= '" + lName.Text + "', users.email= '" + email.Text + "', users.password= '" + createUPwd.Text + "' where id=" + Request.Cookies["UserID"].Value + ";";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlUpdate, sqlConnStr);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();
                Response.Redirect("Login.aspx");

            }
            else
            {
                createUPwd.BorderColor = System.Drawing.Color.Red;
                confirmPWD.BorderColor = System.Drawing.Color.Red;
                email.BorderColor = System.Drawing.Color.Red;
                error2.Text = "Passwords must match -- Email must be vailid";
            }
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            
        }

    }

    public void cancel_Click(object o, EventArgs e)
    {
        Response.Redirect("List.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Account</title>
     <link rel="stylesheet" type="text/css" href="css/Login.css"/>
</head>
<body>
    <div id="createAccDiv">

    <form id="form1" runat="server">
        <asp:label runat="server" ID="labelLogin" />
            <b id="loginTitle">Your Account Information</b>
            <br />

            <span id="spanFname">First Name</span>
            <asp:TextBox runat="server" ID="fName" placeholder="Enter First Name" required="required" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanLname">Last Name</span>
            <asp:TextBox runat="server" ID="lName" placeholder="Enter Last Name" required="required" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanEmail">Email</span>
            <asp:TextBox runat="server" ID="email" placeholder="Enter Email" required="required" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanPwd">Password</span>
            <asp:TextBox runat="server" ID="createUPwd" placeholder="Enter Password" required="required" TextMode="Password" CssClass="Textbox" />
            <br />
            <br />
            <span id="spanPwd2">Confirm Password</span>
            <asp:TextBox runat="server" ID="confirmPWD" placeholder="Confirm Password" required="required" TextMode="Password" CssClass="Textbox" />
            <asp:label runat="server" ID="error2" Text=" " />
            <br />
            <br />
            <asp:Button runat="server" ID="createButton" Text="Update" AutoPostback = "false" onClick="logInButton_Click"/>
            <asp:Button runat="server" ID="cancelButton" Text="Cancel" onClick="cancel_Click" Style="float:left; margin-right:8px;" />
    </form>
    </div>

</body>
</html>