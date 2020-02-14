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
	autoupdate("https://raw.githubusercontent.com/nazpol9/Central-bank-hepler/master/CentralBank.lua", '['..string.upper(thisScript().name)..']: ', "arizona-rp.com")
	sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}Скрипт - Central Bank Helper v0.2 {28FF2B}успешно загружен.', -1)
	sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}Для работы пропишите {28FF2B}/cbhelp или нажмите F3', -1)
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
		            sampSendChat("/me лёгким движением руки снял дубинку с пояса", -1)
		        end
						if gun == 0 then
							sampSendChat("/me лёгким движением руки закрепил дубинку на пояс", -1)
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
        if imgui.Button(u8"Лекции", btn_size) then
            show_lec.v = not show_lec.v
        end
		if imgui.Button(u8"Собеседования", btn_size) then
            show_sobes.v = not show_sobes.v
        end
				if imgui.Button(u8"Депозиты/Карты/Кредиты", btn_size) then
								show_post.v = not show_post.v
						end
						if imgui.Button(u8"Обновления", btn_size) then
										show_obnova.v = not show_obnova.v
								end
						if imgui.CollapsingHeader(u8'Настройки') then
				 	 if imgui.HotKey("##active", ActiveMenu, tLastKeys, 100) then
				       rkeys.changeHotKey(bindID, ActiveMenu.v)
				       sampAddChatMessage("{1288E8}[Bank Script]: " .. table.concat(rkeys.getKeysName(tLastKeys.v), "{FFFFFF} + ") .. "{FFFFFF} | Новое: " .. table.concat(rkeys.getKeysName(ActiveMenu.v), " + "), -1)
				    end
				    imgui.SameLine()
				    imgui.Text(u8("Открыть меню"))
				 	 	 imgui.Text(u8"После перезагрузки скрипта")
				 		 imgui.Text(u8"активация сменится на F3")
						 imgui.Separator()
						 imgui.Text(u8"Выберите стиль:")

						 if imgui.Combo(u8'', selected_item, {u8'Черный', u8'Красный', u8'Желтый', u8'Оранжевый'}, 4) then
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


						if imgui.CollapsingHeader(u8'Команды') then
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

						if imgui.CollapsingHeader(u8'Автор') then
							imgui.TextColored(imgui.ImVec4(0, 143, 194, 1), u8"Автор скрипта:")
							imgui.SameLine()
							imgui.Text(" Angel Mails")
							imgui.Text(u8('О всех багах'))
							imgui.Text(u8"предложениях писать в вк!")
							imgui.Text(u8('Ds - angel mails#1658'))
							if imgui.Button(u8('Связаться с автором в ВК')) then
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
        imgui.Begin(u8'Лекции', show_lec)
        imgui.Text(u8'Выберете тему:')
		local btn_size = imgui.ImVec2(-0.1, 0)
        if imgui.Button(u8"Дресс-Код", btn_size) then
            lua_thread.create(function()
                sampSendChat("Приветствую всех! Сейчас пройдет лекция на Тему - Дресс Код.")
                wait(3000)
                sampSendChat("Каждый сотрудник должен опрятно выглядеть.")
				 wait(3000)
                sampSendChat("Запрещенно носить вызывающие аксесуары, исключение очки,часы.")
				 wait(3000)
                sampSendChat("Форма должна быть стираная и пахнуть нормально!")
				 wait(3000)
                sampSendChat("Если сотрудник будет носить запрещенные аксессуары, то ему будет устное предупреждение.После - выговор!")
				wait(3000)
                sampSendChat("Старайтесь следить за своим внешним видом и выглядеть нормально.")
				wait(3000)
                sampSendChat("На этом лекция на тему: Дресс-Код окончена!")
				wait(3000)
                sampSendChat("/time")
            end)
        end
        if imgui.Button(u8"Устав", btn_size) then
            lua_thread.create(function()
                sampSendChat("Здравствуйте дорогие Банкиры!")
                wait(3000)
                sampSendChat("Сейчас я зачитаю вам лекцию на тему: Устав.")
				 wait(3000)
                sampSendChat("Устав - это свод правил, положений, устанавливающий порядок деятельности.")
				 wait(3000)
                sampSendChat("Знать его обязан каждый сотрудник Банка!")
				 wait(3000)
                sampSendChat("Незнание устава - не освобождает от ответственности.")
				wait(3000)
                sampSendChat("За любое нарушение устава будет наказание, от выговора в плоть до увольнения.")
				wait(3000)
                sampSendChat("На этом лекция на тему \"Устав\" Окончена")
				wait(3000)
                sampSendChat("/time")
            end)
        end
        if imgui.Button(u8"Прав. на тренировке", btn_size) then
            lua_thread.create(function()
                sampSendChat("Всех приветствую!")
                wait(3000)
                sampSendChat("Сегодня я вам проведу лекцию на тему \"Правила поведения на тренировке\"")
				 wait(3000)
                sampSendChat("На тренировке запрещено:")
				 wait(3000)
                sampSendChat("выпрыгивать из строя, кричать,говорить...")
				 wait(3000)
                sampSendChat("...Кушать,пить,курить.")
				wait(3000)
                sampSendChat("На тренировке разрешено:")
				wait(3000)
                sampSendChat("Задавать вопросы подняв руку,покушать,покурить с разрешения, помогать проводящему тренировки...")
				wait(3000)
								sampSendChat("...если ему нужна помощь.")
				wait(3000)
			         	sampSendChat("Ну а на этом лекция на тему \"Правила поведения на тренировке\" Окончена!")
				wait(3000)
                sampSendChat("/time")
            end)
        end
        if imgui.Button(u8"Про Курение", btn_size) then
            lua_thread.create(function()
                sampSendChat("Приветствую.")
                wait(3000)
                sampSendChat("Сегодня я расскажу вам о вреде курения.")
				 wait(3000)
                sampSendChat("Курение - одна из самых знаменитых и распространенных привычек на сегодняшний день.")
				 wait(3000)
                sampSendChat("Запомните, коллеги, несколько вещей.")
				 wait(3000)
                sampSendChat("Курение вызывает рак и хроническое заболевание легких.")
				wait(3000)
                sampSendChat("Также, табачный дым вызывает у некоторых людей всяческие кожные заболевания.")
				wait(3000)
                sampSendChat("Брось сигарету - спаси себя и весь мир!")
				wait(3000)
			         	sampSendChat("Спасибо за внимание, лекция окончена, можете возвращаться к работе.")
				wait(3000)
                sampSendChat("/time")
            end)
        end
				if imgui.Button(u8"Правила общения", btn_size) then
						lua_thread.create(function()
								sampSendChat("Доброго времени суток, уважаемые коллеги.")
					wait(3000)
								sampSendChat("Сейчас я расскажу вам, о правилах порядочного общения с коллегами и клиентами банка.")
				 wait(3000)
								sampSendChat("Каждый сотрудник, обязан относится с уважением к любому клиенту и коллеге.")
				 wait(3000)
								sampSendChat("В нашем банке, строго запрещены конфликты любого рода.")
				 wait(3000)
								sampSendChat("За разжег конфликта, вы будете наказаны, вплоть до увольнения.")
				wait(3000)
								sampSendChat("С клиентами банка обращаться, строго на \"Вы\".")
				wait(3000)
								sampSendChat("Спасибо за внимание!")
				wait(3000)
								sampSendChat("/time")
						end)
				end
				if imgui.Button(u8"Про \"Discord\"", btn_size) then
						lua_thread.create(function()
								sampSendChat("Доброго времени суток, уважаемые коллеги.")
					wait(3000)
								sampSendChat("Сейчас я расскажу вам о спец.рации \"Дискорд\".")
				 wait(3000)
								sampSendChat("Каждый сотрудник обязан иметь данную спец.рацию.")
				 wait(3000)
								sampSendChat("Чтобы подключится на нашу частоту, вам необходимо.")
				 wait(3000)
								sampSendChat("Зайти на официальный портал штата, и там найти нашу частоту.")
				wait(3000)
								sampSendChat("/b На форуме в разделе \"Saint Rose\" - будет указано как подключится к Discord.")
				wait(3000)
								sampSendChat("/b Затем запрашиваете роль - \"#для запроса ролей - /bank123\"")
				wait(3000)
							  sampSendChat("За отсутствие рации, вы не сможете повышаться по карьерной лестнице.")
			 wait(3000)
					    	sampSendChat("Спасибо за внимание!")
			 wait(3000)
							  sampSendChat("/time")
						end)
				end

			imgui.Separator()
			if imgui.Button(u8"Собрать всех", btn_size) then
					lua_thread.create(function()
						sampSendChat("/r Уважаемый состав, попрошу всех собратся в лекционной!")
			wait(2000)
						sampSendChat("/r Даю на сборы 5 минут, попрошу не опаздывать!")
					end)
				end
        imgui.End()
    end
		if show_sobes.v then
			local btn_size = imgui.ImVec2(-0.1, 0)
        imgui.SetNextWindowPos(imgui.ImVec2(sW / 2, sH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(2.5, 0.1))
        imgui.SetNextWindowSize(imgui.ImVec2(250, 410), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Собеседования', show_sobes)
        if imgui.Button(u8"Начать собеседование", btn_size) then
            lua_thread.create(function()
                sampSendChat("Приветствую вас, вы на собеседование?")
            end)
        end
				if imgui.Button(u8"Знакомство", btn_size) then
						lua_thread.create(function()
								sampSendChat("Отлично, представьтесь, расскажите о себе. ")
								wait(3000)
								sampSendChat("Сколько вам лет, где проживаете?!")

						end)
				end
				if imgui.Button(u8"Документы", btn_size) then
						lua_thread.create(function()
								sampSendChat("Хорошо,мне нужен ваш пакет документов,а именно паспорт,мёд.карта,лицензии.")
								wait(3000)
								sampSendChat("/b /showpass /showlic /showmc ")
								wait(3000)
								sampSendChat("/b Обязательно отыгрывая РП Команды - /me /do /todo ")
						end)
				end

				imgui.TextColored(imgui.ImVec4(0, 143, 0, 1), u8"Если с документами все впорядке:")

				if imgui.Button(u8"Адекватность", btn_size) then
						lua_thread.create(function()
								sampSendChat("Так, с документами вроде все в порядке")
								wait(3000)
								sampSendChat("Сейчас я задам вам пару вопросов!")
								wait(3000)
								sampSendChat("Что по вашему такое Адекватность?")
						end)
				end

				if imgui.Button(u8"Дискорд", btn_size) then
						lua_thread.create(function()
								sampSendChat("Хорошо, спец.рацию Дискорд имеете?")
						end)
				end

				if imgui.Button(u8"Принять", btn_size) then
						lua_thread.create(function()
								sampSetChatInputText("/inv ")
								sampSetChatInputEnabled(true)
						end)
				end

				imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8"Если не годен:")

				if imgui.Button(u8"Наркозависимость", btn_size) then
						lua_thread.create(function()
							sampSendChat("Увы, но у вас слишком большая наркозависимость.")
							wait(3000)
							sampSendChat("Лечитесь от нее и приходите в следующий раз.")
						end)
				end

				if imgui.Button(u8"Малый Уровень", btn_size) then
						lua_thread.create(function()
							sampSendChat("Извините, но вы нам не подходите, вы слишком мало проживаете в штате.")
							wait(3000)
							sampSendChat("/b От 3го ЛВЛа")
						end)
				end

				if imgui.Button(u8"Законопослушность", btn_size) then
						lua_thread.create(function()
							sampSendChat("Извините, но вы не слишком законопослушны.")
							wait(3000)
							sampSendChat("/b Законопослушность +35")
						end)
				end

				if imgui.Button(u8"Своя причина", btn_size) then
						lua_thread.create(function()
							sampSendChat("Увы, но вы нам не подходите!")
              wait(1000)
							sampSetChatInputText("По причине: ")
							sampSetChatInputEnabled(true)
						end)
				end


				imgui.End()
    end

    if show_post.v then
			local btn_size = imgui.ImVec2(-0.1, 0)
        imgui.SetNextWindowPos(imgui.ImVec2(sW / 2, sH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(2.5, 0.1))
        imgui.SetNextWindowSize(imgui.ImVec2(250, 410), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Карты/Депозиты/Кредиты', show_post)
				if imgui.Button(u8"Приветствие", btn_size) then
						lua_thread.create(function()
							sampSendChat("/todo Приветствую, могу-ли я Вам помочь? * поправляя бейджик на груди")
							wait(3000)
							sampSendChat("/do На бейджике написано: Менеджер банка | Brian Randall")
						end)
				end
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"Выдача банковской карты:")
				if imgui.Button(u8"Стоимость", btn_size) then
						lua_thread.create(function()
							sampSendChat("Банковская карта стоит 3.000$. Вы готовы оплатить данную сумму?")
						end)
				end
				if imgui.Button(u8"Пароль", btn_size) then
						lua_thread.create(function()
							sampSendChat("/do Ноутбук со счетами в банке на столе.")
								wait(3000)
								sampSendChat("/me написал всю информацию на ноутбук")
									wait(3000)
									sampSendChat("/todo Введите здесь ваш пароль * передавая терминал человеку напротив")
										wait(3000)
										sampSendChat("/do Ноутбук со счетами в банке на столе.")
											wait(3000)

						end)
				end
				if imgui.Button(u8"Выдать", btn_size) then
						lua_thread.create(function()
							sampSendChat("/me аккуратно поднес к себе терминал и записал всё в ноутбук")
								wait(3000)
								sampSendChat("/do Информация на банковской карте написана.")
									wait(3000)
									sampSendChat("/me взял в руку банковскую карту, затем передал человеку напротив")
										wait(3000)
										sampSetChatInputText("/bankmenu ")
										sampSetChatInputEnabled(true)
											wait(7000)
											sampSendChat("/time")
		     end)
				end
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"Пополнение/снятие депозита:")
				_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
				if imgui.Button(u8"Паспорт", btn_size) then
						lua_thread.create(function()
							sampSendChat("Прошу передать мне Ваш паспорт.")
								wait(2000)
								sampSendChat(string.format("/b /showpass %d", id))
		     end)
				end
				if imgui.Button(u8"Показать меню", btn_size) then
						lua_thread.create(function()
							sampSendChat("/me протянув руку, взял паспорт и положил его возле ноутбука на столе")
								wait(3000)
								sampSendChat("/me проверив информацию о граждане в базе данных банка, открыл доступ к депозитному счету")
									wait(3000)
									sampSendChat("/todo Готово, можете пользоваться депозитным счётом * вернув паспорт человеку напротив")
										wait(1000)
										sampSetChatInputText("/bankmenu ")
											wait(1000)
											sampSendChat("/time")
										sampSetChatInputEnabled(true)

				 end)
				end
				imgui.Separator()
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"Выдача Кредита:")
				if imgui.Button(u8"Предложить выдачу", btn_size) then
						lua_thread.create(function()
							sampSendChat("Что бы получить кредит, вы не должны иметь проблем с законом и иметь хорошую...")
								wait(2000)
								sampSendChat("...кредитную историю. Если вы согласны, то прошу передать мне свой паспорт.")
							end)
						end
				if imgui.Button(u8"Выдать кредит", btn_size) then
						lua_thread.create(function()
							sampSendChat("/me протянув руку и взяв паспорт у человека напротив, начал заполнять графы выдачи кредита")
								wait(3000)
								sampSendChat("/do Графы заполнены.")
									wait(3000)
									sampSendChat("/todo Всё готово, вот ваш паспорт * возвращая паспорт клиенту")
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
        imgui.Begin(u8'Обновления', show_obnova)
				imgui.TextColored(imgui.ImVec4(0, 125, 0, 1), u8"Updt - v0.2:")
        imgui.Text(u8'1. Добавлено АвтоОтыгровка Оружия, а точнее дубинки, отыгровка взята с Форума Аризона РП Сэинт Роус.')
				imgui.Text(u8'2. В сокращенные команды добавлена команда /exp - /expel. Так же к ней добавлена РП отыгровка.')
				imgui.Text(u8'3. Теперь стиль окна можно выбрать самостоятельно из предложеных мною вам. Сделать это мжоно в')				imgui.Text(u8'меню \"Настройки\" , и там уже выбрать нужный вам стиль.')
				imgui.Text(u8'4. Добавлены новые лекции такие как \"Лекция о спец.рации "Discord\" и \"Лекция про правила порядочного общения\"')
				imgui.Text(u8'5. Теперь если вы хотите собрать всех в лекционной, вы можите в меню Лекий нажать на кнопку \"Собрать всех\"')
				imgui.Text(u8'и скрипт сам отпишет в рацию о сборе людей.')




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
	sampAddChatMessage('{1288E8}[Bank script]{FFFFFF} Вы посмотрели список сотрудников онлайн.', -1)
  sampSendChat('/me взяв в руки попртативный КПК, посмотрел раздел сотрудников')
	sampSendChat('/members')
	sampSendChat('/t')
end

	function cmd_t()
		sampAddChatMessage('{1288E8}[Bank script]{FFFFFF} Вы посмотрели время.', -1)
		sampSendChat('/me закатав рукав, взглянул на часы с гравировкой \"Bank Management\".')
	    sampSendChat('/time')

	end

	function cmd_bl(param)
	    lua_thread.create(function()
		local id, reason = string.match(param, "(%d+) (.+)")
		sampSendChat("/me достав портативный КПК, зашёл в раздел управления данными сотрудников")
		wait(2000)
		sampSendChat("/me открыв нужную информацию, занёс человека в чёрный список")
		wait(2000)
		sampSendChat("/me выключил КПК, после чего сложил его обратно.")
		wait(2000)
		sampSendChat("/blacklist "..id.." "..reason.."")
		wait(2000)
		sampAddChatMessage('{1288E8}[Bank Script]{FFFFFF} Вы занесли человека в Чёрный список Организации.', -1)
		wait(2000)
		sampSendChat('/t')
		 end)
	end


	function cmd_unbl(param)

	    local id = string.match(param, "(%d+)")
	         if #param == 0 then
	               sampAddChatMessage('{1288E8}[Bank Script]{FF02000} Ошибка!{FFFFFF} Введите ID игрока.', -1)
	        else
	            lua_thread.create(function()
	            sampSendChat("/unblacklist "..id)
				wait(2000)
	            sampSendChat("/me достав портативный КПК, зашёл в раздел управления данными сотрудников")
				wait(2000)
				sampSendChat("/me открыв нужную информацию, вынес человека из чёрного списка")
				wait(2000)
				sampSendChat("/me выключил КПК, после чего сложил его обратно")
				wait(2000)
	            sampSendChat("/t")
	            end)
	        end
	end

	function cmd_inv(param)
	    local id = string.match(param, "(%d+)")
	         if #param == 0 then
	               sampAddChatMessage('{1288E8}[Bank Script]{FF0000} Ошибка! {FFFFFF}Введите ID игрока.', -1)
	        else
	            lua_thread.create(function()
	            sampSendChat("/invite "..id)
				sampAddChatMessage(string.format("{FFFFFF}Вы успешно пригласили игрока %s в организацию", sampGetPlayerNickname(param)), -1)
	            sampSendChat("/me достав из кармана новый ключ от шкафчика, передал его человеку напротив")
	            wait(2000)
	            sampSendChat("/todo Вот ваш ключ. Форма и бейджик в шкафчике*передавая ключ человеку")
	            wait(2000)
	            sampSendChat("Удачной вам работы в нашем банке.")
	            wait(2000)
	            sampSendChat(")")
	            sampSendChat("/time")
	            end)
	        end
	end

	function cmd_unv(param)
		local id, reason = string.match(param, "(%d+) (.+)")
		 if #param == 0 then
			   sampAddChatMessage('{1288E8}[Bank Script]{FF0000} Ошибка! {FFFFFF}Введите ID игрока и причину', -1)
		else 
			lua_thread.create(function()
			sampSendChat("/me достав портативный КПК, зашёл в раздел управления данными сотрудников")
			wait(2000)
			sampSendChat("/me нашёл нужного сотрудника, после чего удалил его из базы данных банка")
			wait(2000)
			sampSendChat("/time")
			wait(2000)
			sampSendChat("/uninvite "..id.." "..reason.."")
			wait(2000)
			sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}Вы уволили человека из фракции.', -1)
			end)
		end
	end

	function cmd_gr(param)
		local id, rank = string.match(param, "(%d+) (%d+)")
		 if #param == 0 then
			   sampAddChatMessage('{1288E8}[Bank Script]{FF0000} Ошибка! {FFFFFF}Введите ID игрока и ранг', -1)
		else 
			lua_thread.create(function()
			sampSendChat("/giverank "..id.." "..rank.."")
			sampAddChatMessage('{1288E8}[Bank Script]:{FFFFFF}Вы выдали новый ранг человеку.', -1)
			wait(2000)
			sampSendChat('/me открыв кейс, достал бейджик и передал его человеку напротив')
			wait(2000)
			sampSendChat('/todo Поздравляю, удачи*закрыв кейс и улыбнувшись')
			wait(2000)
			sampSendChat('/time')
			end)
		end
	end

	function cmd_fm(param)
	    lua_thread.create(function()
		local id, time, reason = string.match(param, "(%d+) (%d+) (.+)")
		sampSendChat("/me достав портативный КПК, зашёл в раздел управления данными сотрудников")
		wait(2000)
		sampSendChat("/me нашёл нужного сотрудника и изъял у него доступ к рации")
		wait(2000)
		sampSendChat("/fmute "..id.." "..time.." "..reason.."")
		wait(2000)
		sampSendChat("/me выключил КПК, после чего сложил его обратно")
		wait(2000)
		sampAddChatMessage('{1288E8}[Bank Script]{FFFFFF} Вы выключили рацию человеку.', -1)
		wait(2000)
		sampSendChat('/t')
		end)
	end

	function cmd_unfm(param)
	    local id = string.match(param, "(%d+)")
	         if #param == 0 then
	               sampAddChatMessage('{1288E8}[Bank Script]{FF0000} Ошибка! {FFFFFF}Введите ID игрока.', -1)
	        else
	            lua_thread.create(function()
	         sampSendChat("/me достав портативный КПК, зашёл в раздел управления данными сотрудников")
		     wait(2000)
		     sampSendChat("/me нашёл нужного сотрудника и выдал ему доступ к рации")
		     wait(2000)
			 sampSendChat("/funmute "..id)
			 wait(2000)
		     sampSendChat("/me выключил КПК, после чего сложил его обратно")
		     wait(2000)
	            sampSendChat("/time")
	            end)
end
end

function cmd_exp(param)
	local id, reason = string.match(param, "(%d+) (.+)")
	lua_thread.create(function()
	sampSendChat("/me схватив нарушителя за руку, повёл к выходу и пнул под зад")
	sampAddChatMessage('{1288E8}[Bank Script]: {FFFFFF}Вы выгнали человека с Банка.', -1)
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

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end