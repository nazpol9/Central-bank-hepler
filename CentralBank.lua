script_name("Central Bank Helper")
script_authors("#A.Mails")
script_version("v0.2")
require "lib.moonloader"
local imgui = require 'imgui'
local encoding = require 'encoding'
local inicfg = require 'inicfg'
local rkeys = require 'rkeys'
local vkeys = require 'vkeys'
imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
local main_window_state = imgui.ImBool(false)
encoding.default = 'CP1251'
u8 = encoding.UTF8

local main_window_state = imgui.ImBool(false)
local window = imgui.ImBool(false)
local sW, sH = getScreenResolution()

local show_lec = imgui.ImBool(false)
local show_sobes = imgui.ImBool(false)
local show_post = imgui.ImBool(false)
local show_obnova = imgui.ImBool(false)
selected_item = imgui.ImInt(0)



local window = imgui.ImBool(false)
local ActiveMenu = {
	v = {vkeys.VK_F3}
}
local bindID = 0

function main()
	repeat wait(100) until isSampAvailable()
    if not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
	sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}������ - Central Bank Helper v0.2 {28FF2B}������� ��������.', -1)
	sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}��� ������ ��������� {28FF2B}/cbhelp ��� ������� F3', -1)
	sampRegisterChatCommand('mb', cmd_mb)
	sampRegisterChatCommand('t', cmd_t)
	sampRegisterChatCommand('bm', cmd_bm)
	sampRegisterChatCommand('inv', cmd_inv)
	sampRegisterChatCommand('unv', cmd_unv)
	sampRegisterChatCommand("gr", cmd_gr)
	sampRegisterChatCommand('bl', cmd_bl)
	sampRegisterChatCommand('unbl', cmd_unbl)
	sampRegisterChatCommand('fm', cmd_fm)
	sampRegisterChatCommand('unfm', cmd_unfm)
	sampRegisterChatCommand('exp', cmd_exp)

	myid = sampGetPlayerIdByCharHandle(PLAYER_PED)

	mynick = sampGetPlayerNickname(myid)
	sampRegisterChatCommand("cbhelp", function ()
		main_window_state.v = not main_window_state.v
	end)
	bindID = rkeys.registerHotKey(ActiveMenu.v, true, function ()
		main_window_state.v = not main_window_state.v
	end)
	while true do
		wait(0)
		if lastgun ~= getCurrentCharWeapon(PLAYER_PED) then
		    local gun = getCurrentCharWeapon(PLAYER_PED)
		        if gun == 3 then
		            sampSendChat("/me ����� ��������� ���� ���� ������� � �����", -1)
		        end
						if gun == 0 then
							sampSendChat("/me ����� ��������� ���� �������� ������� �� ����", -1)
						end
		            lastgun = gun
		        end


        imgui.Process = main_window_state.v
	end
end

function imgui.OnDrawFrame()
    if main_window_state.v then
	    local btn_size = imgui.ImVec2(-0.1, 0)
        local iScreenWidth, iScreenHeight = getScreenResolution()
        local tLastKeys = {}
        imgui.SetNextWindowPos(imgui.ImVec2(sW / 2, sH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(-1.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(280, 350), imgui.Cond.FirstUseEver)
        imgui.Begin('Centarl Bank | By A.Mails', main_window_state, imgui.WindowFlags.NoResize)
        if imgui.Button(u8"������", btn_size) then
            show_lec.v = not show_lec.v
        end
		if imgui.Button(u8"�������������", btn_size) then
            show_sobes.v = not show_sobes.v
        end
				if imgui.Button(u8"��������/�����/�������", btn_size) then
								show_post.v = not show_post.v
						end
						if imgui.Button(u8"����������", btn_size) then
										show_obnova.v = not show_obnova.v
								end
						if imgui.CollapsingHeader(u8'���������') then
				 	 if imgui.HotKey("##active", ActiveMenu, tLastKeys, 100) then
				       rkeys.changeHotKey(bindID, ActiveMenu.v)
				       sampAddChatMessage("{1288E8}[Bank Script]: " .. table.concat(rkeys.getKeysName(tLastKeys.v), "{FFFFFF} + ") .. "{FFFFFF} | �����: " .. table.concat(rkeys.getKeysName(ActiveMenu.v), " + "), -1)
				    end
				    imgui.SameLine()
				    imgui.Text(u8("������� ����"))
				 	 	 imgui.Text(u8"����� ������������ �������")
				 		 imgui.Text(u8"��������� �������� �� F3")
						 imgui.Separator()
						 imgui.Text(u8"�������� �����:")

						 if imgui.Combo(u8'', selected_item, {u8'������', u8'�������', u8'������', u8'���������'}, 4) then
			if selected_item.v == 0 then
				style_white()
			end
				if selected_item.v == 1 then
						style_red()
				end
				if selected_item.v == 2 then
					style_yellow()
				end
				if selected_item.v == 3 then
						style_orange()
				end
		end
          end


						if imgui.CollapsingHeader(u8'�������') then
	    imgui.Text(u8("/invite - /inv"))
				    imgui.Text(u8("/uninvite - /unv"))
							    imgui.Text(u8("/giverank - /gr"))
										    imgui.Text(u8("/blacklist - /bl"))
													    imgui.Text(u8("/unblacklist - /unbl"))
																    imgui.Text(u8("/fmute - /fm"))
																			    imgui.Text(u8("/unfmute - /unfm"))
																						    imgui.Text(u8("/members - /mb"))
																									    imgui.Text(u8("/time - /t"))
																											      imgui.Text(u8("/expel - /exp"))



						end

						if imgui.CollapsingHeader(u8'�����') then
							imgui.TextColored(imgui.ImVec4(0, 143, 194, 1), u8"����� �������:")
							imgui.SameLine()
							imgui.Text(" Angel Mails")
							imgui.Text(u8('� ���� �����'))
							imgui.Text(u8"������������ ������ � ��!")
							imgui.Text(u8('Ds - angel mails#1658'))
							if imgui.Button(u8('��������� � ������� � ��')) then
								os.execute('start https://vk.me/angelmails')
							end
              	end

		imgui.Separator()
		imgui.Text("                  Central Bank Helper v0.2")
        imgui.End()
    end
    if show_lec.v then
        imgui.SetNextWindowPos(imgui.ImVec2(sW / 2.5, sH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(2.2, 0.1))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 230), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'������', show_lec)
        imgui.Text(u8'�������� ����:')
		local btn_size = imgui.ImVec2(-0.1, 0)
        if imgui.Button(u8"�����-���", btn_size) then
            lua_thread.create(function()
                sampSendChat("����������� ����! ������ ������� ������ �� ���� - ����� ���.")
                wait(3000)
                sampSendChat("������ ��������� ������ ������� ���������.")
				 wait(3000)
                sampSendChat("���������� ������ ���������� ���������, ���������� ����,����.")
				 wait(3000)
                sampSendChat("����� ������ ���� �������� � ������� ���������!")
				 wait(3000)
                sampSendChat("���� ��������� ����� ������ ����������� ����������, �� ��� ����� ������ ��������������.����� - �������!")
				wait(3000)
                sampSendChat("���������� ������� �� ����� ������� ����� � ��������� ���������.")
				wait(3000)
                sampSendChat("�� ���� ������ �� ����: �����-��� ��������!")
				wait(3000)
                sampSendChat("/time")
            end)
        end
        if imgui.Button(u8"�����", btn_size) then
            lua_thread.create(function()
                sampSendChat("������������ ������� �������!")
                wait(3000)
                sampSendChat("������ � ������� ��� ������ �� ����: �����.")
				 wait(3000)
                sampSendChat("����� - ��� ���� ������, ���������, ��������������� ������� ������������.")
				 wait(3000)
                sampSendChat("����� ��� ������ ������ ��������� �����!")
				 wait(3000)
                sampSendChat("�������� ������ - �� ����������� �� ���������������.")
				wait(3000)
                sampSendChat("�� ����� ��������� ������ ����� ���������, �� �������� � ����� �� ����������.")
				wait(3000)
                sampSendChat("�� ���� ������ �� ���� \"�����\" ��������")
				wait(3000)
                sampSendChat("/time")
            end)
        end
        if imgui.Button(u8"����. �� ����������", btn_size) then
            lua_thread.create(function()
                sampSendChat("���� �����������!")
                wait(3000)
                sampSendChat("������� � ��� ������� ������ �� ���� \"������� ��������� �� ����������\"")
				 wait(3000)
                sampSendChat("�� ���������� ���������:")
				 wait(3000)
                sampSendChat("����������� �� �����, �������,��������...")
				 wait(3000)
                sampSendChat("...������,����,������.")
				wait(3000)
                sampSendChat("�� ���������� ���������:")
				wait(3000)
                sampSendChat("�������� ������� ������ ����,��������,�������� � ����������, �������� ����������� ����������...")
				wait(3000)
								sampSendChat("...���� ��� ����� ������.")
				wait(3000)
			         	sampSendChat("�� � �� ���� ������ �� ���� \"������� ��������� �� ����������\" ��������!")
				wait(3000)
                sampSendChat("/time")
            end)
        end
        if imgui.Button(u8"��� �������", btn_size) then
            lua_thread.create(function()
                sampSendChat("�����������.")
                wait(3000)
                sampSendChat("������� � �������� ��� � ����� �������.")
				 wait(3000)
                sampSendChat("������� - ���� �� ����� ���������� � ���������������� �������� �� ����������� ����.")
				 wait(3000)
                sampSendChat("���������, �������, ��������� �����.")
				 wait(3000)
                sampSendChat("������� �������� ��� � ����������� ����������� ������.")
				wait(3000)
                sampSendChat("�����, �������� ��� �������� � ��������� ����� ��������� ������ �����������.")
				wait(3000)
                sampSendChat("����� �������� - ����� ���� � ���� ���!")
				wait(3000)
			         	sampSendChat("������� �� ��������, ������ ��������, ������ ������������ � ������.")
				wait(3000)
                sampSendChat("/time")
            end)
        end
				if imgui.Button(u8"������� �������", btn_size) then
						lua_thread.create(function()
								sampSendChat("������� ������� �����, ��������� �������.")
					wait(3000)
								sampSendChat("������ � �������� ���, � �������� ����������� ������� � ��������� � ��������� �����.")
				 wait(3000)
								sampSendChat("������ ���������, ������ ��������� � ��������� � ������ ������� � �������.")
				 wait(3000)
								sampSendChat("� ����� �����, ������ ��������� ��������� ������ ����.")
				 wait(3000)
								sampSendChat("�� ������ ���������, �� ������ ��������, ������ �� ����������.")
				wait(3000)
								sampSendChat("� ��������� ����� ����������, ������ �� \"��\".")
				wait(3000)
								sampSendChat("������� �� ��������!")
				wait(3000)
								sampSendChat("/time")
						end)
				end
				if imgui.Button(u8"��� \"Discord\"", btn_size) then
						lua_thread.create(function()
								sampSendChat("������� ������� �����, ��������� �������.")
					wait(3000)
								sampSendChat("������ � �������� ��� � ����.����� \"�������\".")
				 wait(3000)
								sampSendChat("������ ��������� ������ ����� ������ ����.�����.")
				 wait(3000)
								sampSendChat("����� ����������� �� ���� �������, ��� ����������.")
				 wait(3000)
								sampSendChat("����� �� ����������� ������ �����, � ��� ����� ���� �������.")
				wait(3000)
								sampSendChat("/b �� ������ � ������� \"Saint Rose\" - ����� ������� ��� ����������� � Discord.")
				wait(3000)
								sampSendChat("/b ����� ������������ ���� - \"#��� ������� ����� - /bank123\"")
				wait(3000)
							  sampSendChat("�� ���������� �����, �� �� ������� ���������� �� ��������� ��������.")
			 wait(3000)
					    	sampSendChat("������� �� ��������!")
			 wait(3000)
							  sampSendChat("/time")
						end)
				end

			imgui.Separator()
			if imgui.Button(u8"������� ����", btn_size) then
					lua_thread.create(function()
						sampSendChat("/r ��������� ������, ������� ���� �������� � ����������!")
			wait(2000)
						sampSendChat("/r ��� �� ����� 5 �����, ������� �� ����������!")
					end)
				end
        imgui.End()
    end
		if show_sobes.v then
			local btn_size = imgui.ImVec2(-0.1, 0)
        imgui.SetNextWindowPos(imgui.ImVec2(sW / 2, sH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(2.5, 0.1))
        imgui.SetNextWindowSize(imgui.ImVec2(250, 410), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'�������������', show_sobes)
        if imgui.Button(u8"������ �������������", btn_size) then
            lua_thread.create(function()
                sampSendChat("����������� ���, �� �� �������������?")
            end)
        end
				if imgui.Button(u8"����������", btn_size) then
						lua_thread.create(function()
								sampSendChat("�������, �������������, ���������� � ����. ")
								wait(3000)
								sampSendChat("������� ��� ���, ��� ����������?!")

						end)
				end
				if imgui.Button(u8"���������", btn_size) then
						lua_thread.create(function()
								sampSendChat("������,��� ����� ��� ����� ����������,� ������ �������,��.�����,��������.")
								wait(3000)
								sampSendChat("/b /showpass /showlic /showmc ")
								wait(3000)
								sampSendChat("/b ����������� ��������� �� ������� - /me /do /todo ")
						end)
				end

				imgui.TextColored(imgui.ImVec4(0, 143, 0, 1), u8"���� � ����������� ��� ��������:")

				if imgui.Button(u8"������������", btn_size) then
						lua_thread.create(function()
								sampSendChat("���, � ����������� ����� ��� � �������")
								wait(3000)
								sampSendChat("������ � ����� ��� ���� ��������!")
								wait(3000)
								sampSendChat("��� �� ������ ����� ������������?")
						end)
				end

				if imgui.Button(u8"�������", btn_size) then
						lua_thread.create(function()
								sampSendChat("������, ����.����� ������� ������?")
						end)
				end

				if imgui.Button(u8"�������", btn_size) then
						lua_thread.create(function()
								sampSetChatInputText("/inv ")
								sampSetChatInputEnabled(true)
						end)
				end

				imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8"���� �� �����:")

				if imgui.Button(u8"����������������", btn_size) then
						lua_thread.create(function()
							sampSendChat("���, �� � ��� ������� ������� ����������������.")
							wait(3000)
							sampSendChat("�������� �� ��� � ��������� � ��������� ���.")
						end)
				end

				if imgui.Button(u8"����� �������", btn_size) then
						lua_thread.create(function()
							sampSendChat("��������, �� �� ��� �� ���������, �� ������� ���� ���������� � �����.")
							wait(3000)
							sampSendChat("/b �� 3�� ����")
						end)
				end

				if imgui.Button(u8"�����������������", btn_size) then
						lua_thread.create(function()
							sampSendChat("��������, �� �� �� ������� ��������������.")
							wait(3000)
							sampSendChat("/b ����������������� +35")
						end)
				end

				if imgui.Button(u8"���� �������", btn_size) then
						lua_thread.create(function()
							sampSendChat("���, �� �� ��� �� ���������!")
              wait(1000)
							sampSetChatInputText("�� �������: ")
							sampSetChatInputEnabled(true)
						end)
				end


				imgui.End()
    end

    if show_post.v then
			local btn_size = imgui.ImVec2(-0.1, 0)
        imgui.SetNextWindowPos(imgui.ImVec2(sW / 2, sH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(2.5, 0.1))
        imgui.SetNextWindowSize(imgui.ImVec2(250, 410), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'�����/��������/�������', show_post)
				if imgui.Button(u8"�����������", btn_size) then
						lua_thread.create(function()
							sampSendChat("/todo �����������, ����-�� � ��� ������? * ��������� ������� �� �����")
							wait(3000)
							sampSendChat("/do �� �������� ��������: �������� ����� | Brian Randall")
						end)
				end
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"������ ���������� �����:")
				if imgui.Button(u8"���������", btn_size) then
						lua_thread.create(function()
							sampSendChat("���������� ����� ����� 3.000$. �� ������ �������� ������ �����?")
						end)
				end
				if imgui.Button(u8"������", btn_size) then
						lua_thread.create(function()
							sampSendChat("/do ������� �� ������� � ����� �� �����.")
								wait(3000)
								sampSendChat("/me ������� ��� ���������� �� �������")
									wait(3000)
									sampSendChat("/todo ������� ����� ��� ������ * ��������� �������� �������� ��������")
										wait(3000)
										sampSendChat("/do ������� �� ������� � ����� �� �����.")
											wait(3000)

						end)
				end
				if imgui.Button(u8"������", btn_size) then
						lua_thread.create(function()
							sampSendChat("/me ��������� ������ � ���� �������� � ������� �� � �������")
								wait(3000)
								sampSendChat("/do ���������� �� ���������� ����� ��������.")
									wait(3000)
									sampSendChat("/me ���� � ���� ���������� �����, ����� ������� �������� ��������")
										wait(3000)
										sampSetChatInputText("/bankmenu ")
										sampSetChatInputEnabled(true)
											wait(7000)
											sampSendChat("/time")
		     end)
				end
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"����������/������ ��������:")
				_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
				if imgui.Button(u8"�������", btn_size) then
						lua_thread.create(function()
							sampSendChat("����� �������� ��� ��� �������.")
								wait(2000)
								sampSendChat(string.format("/b /showpass %d", id))
		     end)
				end
				if imgui.Button(u8"�������� ����", btn_size) then
						lua_thread.create(function()
							sampSendChat("/me �������� ����, ���� ������� � ������� ��� ����� �������� �� �����")
								wait(3000)
								sampSendChat("/me �������� ���������� � �������� � ���� ������ �����, ������ ������ � ����������� �����")
									wait(3000)
									sampSendChat("/todo ������, ������ ������������ ���������� ������ * ������ ������� �������� ��������")
										wait(1000)
										sampSetChatInputText("/bankmenu ")
											wait(1000)
											sampSendChat("/time")
										sampSetChatInputEnabled(true)

				 end)
				end
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"������ �������:")
				if imgui.Button(u8"���������� ������", btn_size) then
						lua_thread.create(function()
							sampSendChat("��� �� �������� ������, �� �� ������ ����� ������� � ������� � ����� �������...")
								wait(2000)
								sampSendChat("...��������� �������. ���� �� ��������, �� ����� �������� ��� ���� �������.")
							end)
						end
				if imgui.Button(u8"������ ������", btn_size) then
						lua_thread.create(function()
							sampSendChat("/me �������� ���� � ���� ������� � �������� ��������, ����� ��������� ����� ������ �������")
								wait(3000)
								sampSendChat("/do ����� ���������.")
									wait(3000)
									sampSendChat("/todo �� ������, ��� ��� ������� * ��������� ������� �������")
										wait(3000)
										sampSetChatInputText("/bankmenu ")
										sampSetChatInputEnabled(true)
				 end)
			 end
        imgui.End()
    end
		if show_obnova.v then
        imgui.SetNextWindowPos(imgui.ImVec2(sW / 2, sH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 700), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'����������', show_obnova)
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"Updt - v0.2:")
        imgui.Text(u8'1. ��������� ������������� ������, � ������ �������, ��������� ����� � ������ ������� �� ����� ����.')
				imgui.Text(u8'2. � ����������� ������� ��������� ������� /exp - /expel. ��� �� � ��� ��������� �� ���������.')
				imgui.Text(u8'3. ������ ����� ���� ����� ������� �������������� �� ����������� ���� ���. ������� ��� ����� �')				imgui.Text(u8'���� \"���������\" , � ��� ��� ������� ������ ��� �����.')
				imgui.Text(u8'4. ��������� ����� ������ ����� ��� \"������ � ����.����� "Discord\" � \"������ ��� ������� ����������� �������\"')
				imgui.Text(u8'5. ������ ���� �� ������ ������� ���� � ����������, �� ������ � ���� ����� ������ �� ������ \"������� ����\"')
				imgui.Text(u8'� ������ ��� ������� � ����� � ����� �����.')




        imgui.End()
    end
	end



function style_orange()
imgui.SwitchContext()
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
local ImVec2 = imgui.ImVec2

style.WindowPadding = ImVec2(15, 15)
style.WindowRounding = 6.0
style.FramePadding = ImVec2(5, 5)
style.FrameRounding = 4.0
style.ItemSpacing = ImVec2(12, 8)
style.ItemInnerSpacing = ImVec2(8, 6)
style.IndentSpacing = 25.0
style.ScrollbarSize = 15.0
style.ScrollbarRounding = 9.0
style.GrabMinSize = 5.0
style.GrabRounding = 3.0

colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end


function cmd_mb()
	sampAddChatMessage('{1288E8}[Bank script]{FFFFFF} �� ���������� ������ ����������� ������.', -1)
  sampSendChat('/me ���� � ���� ������������ ���, ��������� ������ �����������')
	sampSendChat('/members')
	sampSendChat('/t')
end

	function cmd_t()
		sampAddChatMessage('{1288E8}[Bank script]{FFFFFF} �� ���������� �����.', -1)
		sampSendChat('/me ������� �����, �������� �� ���� � ����������� \"Bank Management\".')
	    sampSendChat('/time')

	end

	function cmd_bl(param)
	    lua_thread.create(function()
		local id, reason = string.match(param, "(%d+) (.+)")
		sampSendChat("/me ������ ����������� ���, ����� � ������ ���������� ������� �����������")
		wait(2000)
		sampSendChat("/me ������ ������ ����������, ���� �������� � ������ ������")
		wait(2000)
		sampSendChat("/me �������� ���, ����� ���� ������ ��� �������.")
		wait(2000)
		sampSendChat("/blacklist "..id.." "..reason.."")
		wait(2000)
		sampAddChatMessage('{1288E8}[Bank Script]{FFFFFF} �� ������� �������� � ׸���� ������ �����������.', -1)
		wait(2000)
		sampSendChat('/t')
		 end)
	end


	function cmd_unbl(param)

	    local id = string.match(param, "(%d+)")
	         if #param == 0 then
	               sampAddChatMessage('{1288E8}[Bank Script]{FF02000} ������!{FFFFFF} ������� ID ������.', -1)
	        else
	            lua_thread.create(function()
	            sampSendChat("/unblacklist "..id)
				wait(2000)
	            sampSendChat("/me ������ ����������� ���, ����� � ������ ���������� ������� �����������")
				wait(2000)
				sampSendChat("/me ������ ������ ����������, ����� �������� �� ������� ������")
				wait(2000)
				sampSendChat("/me �������� ���, ����� ���� ������ ��� �������")
				wait(2000)
	            sampSendChat("/t")
	            end)
	        end
	end

	function cmd_inv(param)
	    local id = string.match(param, "(%d+)")
	         if #param == 0 then
	               sampAddChatMessage('{1288E8}[Bank Script]{FF0000} ������! {FFFFFF}������� ID ������.', -1)
	        else
	            lua_thread.create(function()
	            sampSendChat("/invite "..id)
				sampAddChatMessage(string.format("{FFFFFF}�� ������� ���������� ������ %s � �����������", sampGetPlayerNickname(param)), -1)
	            sampSendChat("/me ������ �� ������� ����� ���� �� ��������, ������� ��� �������� ��������")
	            wait(2000)
	            sampSendChat("/todo ��� ��� ����. ����� � ������� � ��������*��������� ���� ��������")
	            wait(2000)
	            sampSendChat("������� ��� ������ � ����� �����.")
	            wait(2000)
	            sampSendChat(")")
	            sampSendChat("/time")
	            end)
	        end
	end

	function cmd_unv(param)
		local id, reason = string.match(param, "(%d+) (.+)")
		 if #param == 0 then
			   sampAddChatMessage('{1288E8}[Bank Script]{FF0000} ������! {FFFFFF}������� ID ������ � �������', -1)
		else 
			lua_thread.create(function()
			sampSendChat("/me ������ ����������� ���, ����� � ������ ���������� ������� �����������")
			wait(2000)
			sampSendChat("/me ����� ������� ����������, ����� ���� ������ ��� �� ���� ������ �����")
			wait(2000)
			sampSendChat("/time")
			wait(2000)
			sampSendChat("/uninvite "..id.." "..reason.."")
			wait(2000)
			sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}�� ������� �������� �� �������.', -1)
			end)
		end
	end

	function cmd_gr(param)
		local id, rank = string.match(param, "(%d+) (%d+)")
		 if #param == 0 then
			   sampAddChatMessage('{1288E8}[Bank Script]{FF0000} ������! {FFFFFF}������� ID ������ � ����', -1)
		else 
			lua_thread.create(function()
			sampSendChat("/giverank "..id.." "..rank.."")
			sampAddChatMessage('{1288E8}[Bank Script]:{FFFFFF}�� ������ ����� ���� ��������.', -1)
			wait(2000)
			sampSendChat('/me ������ ����, ������ ������� � ������� ��� �������� ��������')
			wait(2000)
			sampSendChat('/todo ����������, �����*������ ���� � �����������')
			wait(2000)
			sampSendChat('/time')
			end)
		end
	end

	function cmd_fm(param)
	    lua_thread.create(function()
		local id, time, reason = string.match(param, "(%d+) (%d+) (.+)")
		sampSendChat("/me ������ ����������� ���, ����� � ������ ���������� ������� �����������")
		wait(2000)
		sampSendChat("/me ����� ������� ���������� � ����� � ���� ������ � �����")
		wait(2000)
		sampSendChat("/fmute "..id.." "..time.." "..reason.."")
		wait(2000)
		sampSendChat("/me �������� ���, ����� ���� ������ ��� �������")
		wait(2000)
		sampAddChatMessage('{1288E8}[Bank Script]{FFFFFF} �� ��������� ����� ��������.', -1)
		wait(2000)
		sampSendChat('/t')
		end)
	end

	function cmd_unfm(param)
	    local id = string.match(param, "(%d+)")
	         if #param == 0 then
	               sampAddChatMessage('{1288E8}[Bank Script]{FF0000} ������! {FFFFFF}������� ID ������.', -1)
	        else
	            lua_thread.create(function()
	         sampSendChat("/me ������ ����������� ���, ����� � ������ ���������� ������� �����������")
		     wait(2000)
		     sampSendChat("/me ����� ������� ���������� � ����� ��� ������ � �����")
		     wait(2000)
			 sampSendChat("/funmute "..id)
			 wait(2000)
		     sampSendChat("/me �������� ���, ����� ���� ������ ��� �������")
		     wait(2000)
	            sampSendChat("/time")
	            end)
end
end

function cmd_exp(param)
	local id, reason = string.match(param, "(%d+) (.+)")
	lua_thread.create(function()
	sampSendChat("/me ������� ���������� �� ����, ���� � ������ � ���� ��� ���")
	sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}�� ������� �������� � �����.', -1)
	sampSendChat("/expel "..id.." "..reason.."")
	 end)
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end
apply_custom_style()

function style_red()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function style_white()
  --source: https://www.unknowncheats.me/forum/direct3d/189635-imgui-style-settings.html
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4

  style.WindowPadding = imgui.ImVec2(15, 15)
  style.WindowRounding = 1.5
  style.FramePadding = imgui.ImVec2(5, 5)
  style.FrameRounding = 4.0
  style.ItemSpacing = imgui.ImVec2(12, 8)
  style.ItemInnerSpacing = imgui.ImVec2(8, 6)
  style.IndentSpacing = 25.0
  style.ScrollbarSize = 15.0
  style.ScrollbarRounding = 9.0
  style.GrabMinSize = 5.0
  style.GrabRounding = 3.0

  colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
  colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
  colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
  colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
  colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
  colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
  colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
  colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
  colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
  colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
  colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
  colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
  colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
  colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
  colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
  colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
  colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
  colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
  colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
  colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

function style_yellow()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.42, 0.48, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.77, 0.88, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.82, 0.98, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.85, 0.98, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.85, 0.98, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.63, 0.75, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.63, 0.75, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.85, 0.98, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.85, 0.98, 0.26, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.85, 0.98, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end
