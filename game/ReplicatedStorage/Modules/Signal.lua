-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-10 07:36:28
-- Luau version 6, Types version 3
-- Time taken: 0.009974 seconds

local var1_upvw
local function acquireRunnerThreadAndCallEventHandler_upvr(arg1, ...) -- Line 44, Named "acquireRunnerThreadAndCallEventHandler"
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = nil
	arg1(...)
	var1_upvw = var1_upvw
end
local function runEventHandlerInFreeThread_upvr(...) -- Line 55, Named "runEventHandlerInFreeThread"
	--[[ Upvalues[1]:
		[1]: acquireRunnerThreadAndCallEventHandler_upvr (readonly)
	]]
	acquireRunnerThreadAndCallEventHandler_upvr(...)
	while true do
		acquireRunnerThreadAndCallEventHandler_upvr(coroutine.yield())
	end
end
local tbl_3_upvr = {}
tbl_3_upvr.__index = tbl_3_upvr
function tbl_3_upvr.Disconnect(arg1) -- Line 81
	local var3
	if not var3 then
	else
		var3 = false
		arg1.Connected = var3
		var3 = arg1._signal._handlerListHead
		if var3 == arg1 then
			var3 = arg1._signal
			var3._handlerListHead = arg1._next
			return
		end
		var3 = arg1._signal._handlerListHead
		while var3 and var3._next ~= arg1 do
			var3 = var3._next
		end
		if var3 then
			var3._next = arg1._next
		end
	end
end
tbl_3_upvr.Destroy = tbl_3_upvr.Disconnect
local tbl_2 = {}
local function __index(arg1, arg2) -- Line 108
	error("Attempt to get Connection::%s (not a valid member)":format(tostring(arg2)), 2)
end
tbl_2.__index = __index
local function __newindex(arg1, arg2, arg3) -- Line 111
	error("Attempt to set Connection::%s (not a valid member)":format(tostring(arg2)), 2)
end
tbl_2.__newindex = __newindex
setmetatable(tbl_3_upvr, tbl_2)
local tbl_4_upvr = {}
tbl_4_upvr.__index = tbl_4_upvr
function tbl_4_upvr.new() -- Line 153
	--[[ Upvalues[1]:
		[1]: tbl_4_upvr (readonly)
	]]
	return setmetatable({
		_handlerListHead = false;
		_proxyHandler = nil;
		_yieldedThreads = nil;
	}, tbl_4_upvr)
end
function tbl_4_upvr.Wrap(arg1) -- Line 176
	--[[ Upvalues[1]:
		[1]: tbl_4_upvr (readonly)
	]]
	local var7
	if typeof(arg1) ~= "RBXScriptSignal" then
		var7 = false
	else
		var7 = true
	end
	assert(var7, "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got "..typeof(arg1))
	var7 = tbl_4_upvr
	local any_new_result1_upvr = var7.new()
	var7 = arg1:Connect(function(...) -- Line 183
		--[[ Upvalues[1]:
			[1]: any_new_result1_upvr (readonly)
		]]
		any_new_result1_upvr:Fire(...)
	end)
	any_new_result1_upvr._proxyHandler = var7
	return any_new_result1_upvr
end
function tbl_4_upvr.Is(arg1) -- Line 196
	--[[ Upvalues[1]:
		[1]: tbl_4_upvr (readonly)
	]]
	local var10 = false
	if type(arg1) == "table" then
		if getmetatable(arg1) ~= tbl_4_upvr then
			var10 = false
		else
			var10 = true
		end
	end
	return var10
end
function tbl_4_upvr.Connect(arg1, arg2) -- Line 213
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	local tbl = {
		Connected = true;
	}
	tbl._signal = arg1
	tbl._fn = arg2
	tbl._next = false
	local setmetatable_result1 = setmetatable(tbl, tbl_3_upvr)
	if arg1._handlerListHead then
		setmetatable_result1._next = arg1._handlerListHead
		arg1._handlerListHead = setmetatable_result1
		return setmetatable_result1
	end
	arg1._handlerListHead = setmetatable_result1
	return setmetatable_result1
end
function tbl_4_upvr.ConnectOnce(arg1, arg2) -- Line 236
	return arg1:Once(arg2)
end
function tbl_4_upvr.Once(arg1, arg2) -- Line 255
	local var14_upvw = false
	local var15_upvw
	var15_upvw = arg1:Connect(function(...) -- Line 259
		--[[ Upvalues[3]:
			[1]: var14_upvw (read and write)
			[2]: var15_upvw (read and write)
			[3]: arg2 (readonly)
		]]
		if var14_upvw then
		else
			var14_upvw = true
			var15_upvw:Disconnect()
			arg2(...)
		end
	end)
	return var15_upvw
end
function tbl_4_upvr.GetConnections(arg1) -- Line 272
	local module = {}
	local _handlerListHead = arg1._handlerListHead
	while _handlerListHead do
		table.insert(module, _handlerListHead)
	end
	return module
end
function tbl_4_upvr.DisconnectAll(arg1) -- Line 292
	local _handlerListHead_3 = arg1._handlerListHead
	while _handlerListHead_3 do
		_handlerListHead_3.Connected = false
	end
	arg1._handlerListHead = false
	local rawget_result1_3 = rawget(arg1, "_yieldedThreads")
	if rawget_result1_3 then
		for i in rawget_result1_3 do
			if coroutine.status(i) == "suspended" then
				warn(debug.traceback(i, "signal disconnected; yielded thread cancelled", 2))
				task.cancel(i)
			end
		end
		table.clear(arg1._yieldedThreads)
	end
end
function tbl_4_upvr.Fire(arg1, ...) -- Line 327
	--[[ Upvalues[2]:
		[1]: var1_upvw (read and write)
		[2]: runEventHandlerInFreeThread_upvr (readonly)
	]]
	local _handlerListHead_4 = arg1._handlerListHead
	while _handlerListHead_4 do
		if _handlerListHead_4.Connected then
			if not var1_upvw then
				var1_upvw = coroutine.create(runEventHandlerInFreeThread_upvr)
			end
			task.spawn(var1_upvw, _handlerListHead_4._fn, ...)
		end
	end
end
function tbl_4_upvr.FireDeferred(arg1, ...) -- Line 348
	local _handlerListHead_2_upvr = arg1._handlerListHead
	while _handlerListHead_2_upvr do
		task.defer(function(...) -- Line 352
			--[[ Upvalues[1]:
				[1]: _handlerListHead_2_upvr (readonly)
			]]
			if _handlerListHead_2_upvr.Connected then
				_handlerListHead_2_upvr._fn(...)
			end
		end, ...)
	end
end
function tbl_4_upvr.Wait(arg1) -- Line 376
	local rawget_result1_2_upvw = rawget(arg1, "_yieldedThreads")
	if not rawget_result1_2_upvw then
		rawget_result1_2_upvw = {}
		rawset(arg1, "_yieldedThreads", rawget_result1_2_upvw)
	end
	local current_thread_upvr = coroutine.running()
	rawget_result1_2_upvw[current_thread_upvr] = true
	arg1:Once(function(...) -- Line 386
		--[[ Upvalues[2]:
			[1]: rawget_result1_2_upvw (read and write)
			[2]: current_thread_upvr (readonly)
		]]
		rawget_result1_2_upvw[current_thread_upvr] = nil
		task.spawn(current_thread_upvr, ...)
	end)
	return coroutine.yield()
end
function tbl_4_upvr.Destroy(arg1) -- Line 406
	arg1:DisconnectAll()
	local rawget_result1 = rawget(arg1, "_proxyHandler")
	if rawget_result1 then
		rawget_result1:Disconnect()
	end
end
setmetatable(tbl_4_upvr, {
	__index = function(arg1, arg2) -- Line 417, Named "__index"
		error("Attempt to get Signal::%s (not a valid member)":format(tostring(arg2)), 2)
	end;
	__newindex = function(arg1, arg2, arg3) -- Line 420, Named "__newindex"
		error("Attempt to set Signal::%s (not a valid member)":format(tostring(arg2)), 2)
	end;
})
return table.freeze({
	new = tbl_4_upvr.new;
	Wrap = tbl_4_upvr.Wrap;
	Is = tbl_4_upvr.Is;
})
