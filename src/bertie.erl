-module(bertie).
-export([start/0]).
%%-export([store/2, fetch/1]).
%%-import(bitcask, [get/2, put/3,open/2, close/0]).

start() -> 
  %%io:format("1").
  Handle = bitcask:open("bertie_database", [read_write]),
  N = fetch(Handle),                        %%func  
  store(Handle, N+1),                       %%func
  io:format("B been run ~p times~n", [N]),
  bitcask:close(Handle),
  init:stop().

store(Handle, N) ->
  bitcask:put(Handle, <<"B_exec">>, term_to_binary(N)).

fetch(Handle) ->
  case bitcask:get(Handle, <<"B_exec">>) of
    not_found -> 1;
    {ok, Bin} -> binary_to_term(Bin)
  end.
   
