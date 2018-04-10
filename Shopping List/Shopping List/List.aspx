﻿<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    public string userid;

    public void settingsBtn_Click(object o, EventArgs e)
    {

    }

    protected void removeBtn_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in grdItems.Rows)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    string userid = Request.Cookies["UserID"].Value;
                    System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                    string sqlremove = "DELETE FROM list_items WHERE id = @id AND item_name = @name;";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlremove, sqlConnStr);
                    cmd.Parameters.Add("@id", System.Data.SqlDbType.Int);
                    cmd.Parameters["@id"].Value = userid;
                    cmd.Parameters.Add("@name", System.Data.SqlDbType.VarChar, 100);
                    cmd.Parameters["@name"].Value = row.Cells[1].Text;
                    cmd.Connection.Open();
                    cmd.ExecuteNonQuery();
                    cmd.Connection.Close();
                    Response.Redirect("List.aspx");

                }
            }
        }
        catch(System.Data.SqlClient.SqlException ex)
        {

        }
    }
    protected void addBtn_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if ((item.Text == "") || (qty.Text == ""))
            {
                item.BorderColor = System.Drawing.Color.Red;
                qty.BorderColor = System.Drawing.Color.Red;
            }
            else
            {
                System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
                string sqlinsert = "insert into list_items (id, item_name, qty, store, dept, description) values (@id, @item, @qty, @store, @dept, @notes)";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
                cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
                cmd.Parameters.Add("@item", System.Data.SqlDbType.VarChar, 100);
                cmd.Parameters["@item"].Value = item.Text;
                cmd.Parameters.Add("@qty", System.Data.SqlDbType.Int);
                cmd.Parameters["@qty"].Value = qty.Text;
                cmd.Parameters.Add("@store", System.Data.SqlDbType.VarChar, 100);
                cmd.Parameters["@store"].Value = store.Text;
                cmd.Parameters.Add("@dept", System.Data.SqlDbType.VarChar, 50);
                cmd.Parameters["@dept"].Value = dept.Text;
                cmd.Parameters.Add("@notes", System.Data.SqlDbType.VarChar, 500);
                cmd.Parameters["@notes"].Value = notes.Text;
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("List.aspx");
                cmd.Connection.Close();
            }
        }
        catch(System.FormatException ex) {
            item.BorderColor = System.Drawing.Color.Red;
            qty.BorderColor = System.Drawing.Color.Red;}


    }

    public void freqaddBtn_Click(object o, EventArgs e)
    {
        try {
            System.Data.SqlClient.SqlConnection sqlConnStr = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["team05"].ConnectionString);
            string sqlinsert = "insert into freq_item (id, item_name) values (@id, @item)";
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlinsert, sqlConnStr);
            cmd.Parameters.AddWithValue("@id", Request.Cookies["UserID"].Value);
            cmd.Parameters.AddWithValue("@item", addfreq.Text);
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            Response.Redirect("List.aspx");
            cmd.Connection.Close();
        }
        catch(System.FormatException ex)
        {
            addfreq.BorderColor = System.Drawing.Color.Red;
        }
    }

    public void show_list(object o, EventArgs e)
    {
        form1.Visible = false;
        freqitemsform.Visible = true;
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping List</title>
     <link rel="stylesheet" type="text/css" href="css/List.css"/>
</head>
<body>
    <form id="form1" visible="true" runat="server">
        
       <div id="icons">
           <asp:ImageButton ID="settingsBtn" ImageUrl="Images/settings.png" OnClick="settingsBtn_Click" runat="server" />
            <asp:ImageButton ID="userBtn" ImageUrl="Images/usericon.png" OnClick="settingsBtn_Click" runat="server" />
           <img src="images/bag.png" alt="Bag" id="loginImage"/>
            <br />
           <br />

       </div>
        
        <div id="frequentitems">
            
            <asp:label runat="server" ID="labelfreqitems"/>
            <b id="freqitemsTitle">Frequent Items</b>
            <br />
             <asp:GridView
                id="freqitems"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle BackColor="SaddleBrown" />
                <HeaderStyle CssClass="Headertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>     
             </Columns>
            </asp:GridView>
            <asp:SqlDataSource
                id="freq_items_source"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, last_purchase_date as 'Last Purchased' from freq_item where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br \ />
            <br \ />
            <asp:TextBox runat="server" ID="addfreq" placeholder="Frequent Item" CssClass="Textbox" />
                <asp:ImageButton ID="freqplus" ImageUrl="Images/add.png" OnClick="freqaddBtn_Click" runat="server" />
            <asp:Button runat="server" ID="addfromlist" OnClick="show_list" Text="Add from Recent Items" />
            
        </div>
        <br/>
        <div id="list_items">
            <asp:label runat="server" ID="labellistitems"/>
            <b id="itemsTitle">My Shopping List</b>
            <br />
            <br />
            <asp:GridView
                id="grdItems"
                DataSourceID="regitems"
                CellPadding="10" 
                border="0"
                GridLines="None"
                Runat="server">
                <EditRowStyle BackColor="brown" />
                <HeaderStyle BackColor="SaddleBrown" />
                <HeaderStyle CssClass="Headertext" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>     
             </Columns>
               
            </asp:GridView>
            
            <asp:Button runat="server" ID="gotit" OnClick="removeBtn_Click" Text="Got It!" />
            <br /><br />
            <asp:SqlDataSource
                id="regitems"
                ConnectionString="<%$ ConnectionStrings:team05 %>"
                SelectCommand="SELECT item_name as Item, qty as QTY, store as Store, dept AS Dept, description as Notes from list_items where id = @id"
                Runat="server">
                <SelectParameters>
                    <asp:CookieParameter CookieName="UserID" Name="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        
            <div id="add">
                <asp:TextBox runat="server" ID="item" placeholder="Item"  CssClass="Textbox" />
                <asp:TextBox runat="server" ID="qty" placeholder="Quantity" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="store" placeholder="Store" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="dept" placeholder="Department" CssClass="Textbox" />
                <asp:TextBox runat="server" ID="notes" placeholder="Notes" CssClass="TextboxLong" />
                <asp:ImageButton ID="addBtn" ImageUrl="Images/add.png" OnClick="addBtn_Click" runat="server" />
            </div>

        </div>
        <br />
        <br />
        <div id="options">
            <a href="storeLocator.html" style="text-decoration: none; font-family: Lucida Sans Unicode Lucida Grande, sans-serif;" >Store Locator</a>
            <br />
            <asp:LinkButton runat="server" ID="signoutButton" Text="Sign Out" PostBackURL="Login.aspx" />
        </div>
            
    </form>

    <form id="freqitemsform" visible="false" runat="server">


    </form>
</body>
</html>
