return function(Fluent)
    -- ตรวจสอบตำแหน่งของ Tab Class ใน Fluent Renewed
    -- โดยปกติจะอยู่ที่ Fluent.Elements.Tab
    local TabClass = Fluent.Tab or (Fluent.Elements and Fluent.Elements.Tab)

    if not TabClass then
        warn("EfHub Error: ไม่สามารถค้นหา Tab Class ใน Library นี้ได้")
        return
    end

    function TabClass:AddCollapsibleSection(Title, Opened)
        local Section = {}
        local ParentTab = self

        -- กำหนดค่าเริ่มต้นให้ Opened
        if Opened == nil then
            Opened = false
        end

        -- Main Container สำหรับ Section
        local Holder = Instance.new("Frame")
        Holder.Name = "CollapsibleSection_" .. Title
        Holder.BackgroundTransparency = 1
        Holder.Size = UDim2.new(1, 0, 0, 30)
        Holder.ClipsDescendants = true
        Holder.Parent = ParentTab.Container

        local Layout = Instance.new("UIListLayout")
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0, 6)
        Layout.Parent = Holder

        -- Header (ปุ่มเปิด-ปิด)
        local Header = Instance.new("TextButton")
        Header.Name = "Header"
        Header.Text = (Opened and "▼  " or "▶  ") .. Title
        Header.Font = Enum.Font.GothamMedium
        Header.TextSize = 13
        Header.TextXAlignment = Enum.TextXAlignment.Left
        Header.Size = UDim2.new(1, 0, 0, 30)
        Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Header.TextColor3 = Color3.fromRGB(200, 200, 200)
        Header.AutoButtonColor = true
        Header.LayoutOrder = 1
        Header.Parent = Holder

        local Padding = Instance.new("UIPadding")
        Padding.PaddingLeft = UDim.new(0, 10)
        Padding.Parent = Header

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 4)
        Corner.Parent = Header

        -- Content
        local Content = Instance.new("Frame")
        Content.Name = "Content"
        Content.BackgroundTransparency = 1
        Content.Size = UDim2.new(1, 0, 0, 0)
        Content.Visible = Opened
        Content.LayoutOrder = 2
        Content.Parent = Holder

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 6)
        ContentLayout.Parent = Content

        -- ฟังก์ชัน Update ขนาด
        local function Update()
            if Content.Visible then
                Content.Size = UDim2.new(1, 0, 0, ContentLayout.AbsoluteContentSize.Y)
                Holder.Size = UDim2.new(1, 0, 0, Header.AbsoluteSize.Y + ContentLayout.AbsoluteContentSize.Y + 8)
            else
                Holder.Size = UDim2.new(1, 0, 0, Header.AbsoluteSize.Y)
            end
        end

        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(Update)

        Header.MouseButton1Click:Connect(function()
            Opened = not Opened
            Content.Visible = Opened
            Header.Text = (Opened and "▼  " or "▶  ") .. Title
            Update()
        end)

        -- Bridge สำหรับเชื่อมต่อ Elements
        function Section:_Attach(Element)
            if Element and Element.Frame then
                Element.Frame.Parent = Content
                Update()
            end
            return Element
        end

        -- Mapping Methods
        function Section:AddToggle(Id, Config)
            return Section:_Attach(ParentTab:AddToggle(Id, Config))
        end
        function Section:AddSlider(Id, Config)
            return Section:_Attach(ParentTab:AddSlider(Id, Config))
        end
        function Section:AddDropdown(Id, Config)
            return Section:_Attach(ParentTab:AddDropdown(Id, Config))
        end
        function Section:AddInput(Id, Config)
            return Section:_Attach(ParentTab:AddInput(Id, Config))
        end
        function Section:AddButton(Config)
            return Section:_Attach(ParentTab:AddButton(Config))
        end
        function Section:AddColorpicker(Id, Config)
            return Section:_Attach(ParentTab:AddColorpicker(Id, Config))
        end
        function Section:AddParagraph(Config)
            return Section:_Attach(ParentTab:AddParagraph(Config))
        end

        task.spawn(Update)
        return Section
    end
end
