<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void logInButton_Click(object sender, EventArgs e)
    {
        if (createUPwd.Text == confirmPWD.Text)
        {
            //add to db
            Response.Redirect("Default.aspx");
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
            <asp:LinkButton runat="server" ID="logInButton" Text="Login" PostBackURL="Default.aspx" />
        </asp:label>
    </form>
    </div>

</body>
</html>