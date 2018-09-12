<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PartsAndVendors.PVMain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
<%--        function displaySearchFor() {
            var searchBy = document.getElementById("<%=drpSearchBy.ClientID%>");
            var searchFor = document.getElementById("<%=drpSearchFor.ClientID%>");
            var butSearch = document.getElementById("<%=butSearch.ClientID%>");

            if (searchBy != "--Select Field--") {
                searchFor.style.display = searchBy.value == "--Select Field--" ? "none" : "block";
                butSearch.style.display = searchBy.value == "--Select Field--" ? "none" : "block";
            }

            return false;--%>
    </script>
    <div id="butBar">
        <div id="filterDiv">
            <asp:DropDownList ID="drpSearchBy" CssClass="searchDropDown searchDropDownSearchBy" runat="server" 
                AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="drpSearchBy_SelectedIndexChanged">
                <asp:ListItem>--Select Field--</asp:ListItem>
                <asp:ListItem>Cage Code</asp:ListItem>
                <asp:ListItem>COG</asp:ListItem>
                <asp:ListItem>FSC</asp:ListItem>
                <asp:ListItem>NIIN</asp:ListItem>
                <asp:ListItem>Parent Assembly</asp:ListItem>
                <asp:ListItem>Part Number</asp:ListItem>
                <asp:ListItem>Title</asp:ListItem>
            </asp:DropDownList>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <asp:DropDownList ID="drpSearchFor" CssClass="searchDropDown searchDropDownSearchFor" runat="server"></asp:DropDownList>
                    <asp:Button ID="butSearch" CssClass="searchButton" runat="server" Text="Button" OnClick="butSearch_Click" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="drpSearchBy" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div id="butDiv">
            <asp:Button ID="butMaster" CssClass="menuButtons menuButtonMaster" runat="server" />
            <asp:Button ID="butParts" CssClass="menuButtons menuButtonsParts" runat="server" />
            <asp:Button ID="butVendors" CssClass="menuButtons menuButtonVendors" runat="server" />
        </div>
        <div id="viewDiv">
            <asp:MultiView ID="mvPV" runat="server" ActiveViewIndex="0">
                <asp:View ID="masterView" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div id="masterDiv">
                                <div id="grdViewDiv" style="height:400px; width:750px; overflow:auto; left:25px; top:65px;">
                                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Both" Height="400" Width="100%">
                                        <asp:GridView ID="grdMaster" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                            <Columns>
                                                <asp:BoundField DataField="PartNum" HeaderText="PartNum" SortExpression="PartNum" />
                                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                                <asp:BoundField DataField="ParentAssy" HeaderText="ParentAssy" SortExpression="ParentAssy" />
                                                <asp:BoundField DataField="CageCode" HeaderText="CageCode" SortExpression="CageCode" />
                                                <asp:BoundField DataField="FSC" HeaderText="FSC" SortExpression="FSC" />
                                                <asp:BoundField DataField="NIIN" HeaderText="NIIN" SortExpression="NIIN" />
                                                <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
                                                <asp:BoundField DataField="UI" HeaderText="UI" SortExpression="UI" />
                                                <asp:BoundField DataField="CurCost" HeaderText="CurCost" SortExpression="CurCost" />
                                                <asp:BoundField DataField="Ref(t)" HeaderText="Ref(t)" SortExpression="Ref(t)" />
                                                <asp:BoundField DataField="UID" HeaderText="UID" SortExpression="UID" />
                                                <asp:BoundField DataField="SMR" HeaderText="SMR" SortExpression="SMR" />
                                                <asp:BoundField DataField="Comments" HeaderText="Comments" SortExpression="Comments" />
                                            </Columns>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                            <RowStyle ForeColor="#000066" Font-Size="Smaller" />
                                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                            <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                            <SortedDescendingHeaderStyle BackColor="#00547E" />
                                        </asp:GridView>
                                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:InteractiveMaterialManagementSystem_TestDBConnectionString %>" SelectCommand="SELECT [PartNum], [Title], [ParentAssy], [CageCode], [FSC], [NIIN], [Qty], [UI], [CurCost], [Ref(t)] AS column1, [UID], [SMR], [Comments] FROM [41BPartsList]"></asp:SqlDataSource>
                                    </asp:Panel>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="butSearch" />
                        </Triggers>
                    </asp:UpdatePanel>
                </asp:View>
                <asp:View ID="partsView" runat="server"></asp:View>
                <asp:View ID="vendorView" runat="server"></asp:View>
            </asp:MultiView>
        </div>
    </div>
</asp:Content>
