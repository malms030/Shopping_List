<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    void Page_Load (){
        //System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
        //string sqlselect = "Select @";
        //System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
    }
    protected void logInButton_Click(object sender, EventArgs e)
    {
        try
        {
            if (createUPwd.Text == confirmPWD.Text && email.Text.Contains("@"))
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlinsert = "insert into users(username, firstname, lastname, email,password) values (@uid, @fname, @lname, @email, @pwd)";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
                cmd.Parameters.Add("@uid", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@uid"].Value = createUid.Text;
                cmd.Parameters.Add("@pwd", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@pwd"].Value = confirmPWD.Text;
                cmd.Parameters.Add("@fname", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@fname"].Value = fName.Text;
                cmd.Parameters.Add("@lname", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@lname"].Value = lName.Text;
                cmd.Parameters.Add("@email", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@email"].Value = email.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("Login.aspx");
                cmd.Connection.Close();
            }
            else
            {
                createUPwd.BorderColor = System.Drawing.Color.Red;
                confirmPWD.BorderColor = System.Drawing.Color.Red;
                email.BorderColor = System.Drawing.Color.Red;
                error2.Text = "Passwords must match -- Email must be vailid";
            }
        }
        catch (System.Data.SqlClient.SqlException ex){
            error.Text = "Username is aready in use :(";
            createUid.BorderColor = System.Drawing.Color.Red;
        }
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
            <span id="spanUid">Username</span>
            <asp:TextBox runat="server" ID="createUid" placeholder="Enter Username" required="required" CssClass="Textbox" />
            <asp:label runat="server" ID="error" Text=" " />
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
            <asp:Button runat="server" ID="createButton" Text="Update" onClick="logInButton_Click"/>
            <asp:Button runat="server" ID="cancelButton" Text="Cancel" Style="float:left; margin-right:8px;" />
    </form>
    </div>

</body>
</html>