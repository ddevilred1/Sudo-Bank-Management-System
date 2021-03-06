create or replace package Transactions as
	
	procedure withdraw(
	ano in accTable_syl.anum%TYPE, 
	amoun in accTable_syl.amount%TYPE);
	
	/*
	procedure withdrawAtm(
	atm in accTable_syl.atmno%TYPE, 
	amoun in accTable_syl.amount%TYPE);
	
	
	procedure deposit(
	ano in accTable_syl.anum%TYPE, 
	amoun in accTable_syl.amount%TYPE);
	
	procedure Transfer(
	senano in accTable_syl.anum%TYPE, 
	amoun in accTable_syl.amount%TYPE,
	recano in accTable_syl.anum%TYPE);
	*/
	
end Transactions;
/

create or replace package body Transactions as
	
	create or replace procedure withdraw(
		ano in accTable_syl.anum%TYPE, 
		amoun in accTable_syl.amount%TYPE)
		is
		
		n int;
		m int; --1 for ctg, 2 for dhk, 3 for syl
		now accTable_syl.amount%TYPE;
		num accTable_syl.withnum%TYPE;
		
		neg exception;
		credit exception;
		nouser exception;
		lim exception;
		/*
		cursor accCur1(aid accTable_syl.anum%TYPE) is
			select amount, withnum from accTable_ctg@site_ctg where anum = aid;
		cursor accCur2(aid accTable_syl.anum%TYPE) is
			select amount, withnum from accTable_dhk@site_dhk where anum = aid;
		cursor accCur3(aid accTable_syl.anum%TYPE) is
			select amount, withnum from accTable_syl where anum = aid;
	*/
	begin
		NULL;
		/*
		if ano > 4000 and ano < 5000 then
			select count(anum) into n from accTable_dhk@site_dhk where anum = ano;
			m := 2;
		elsif ano > 5000 and ano < 6000 then
			select count(anum) into n from accTable_ctg@site_ctg where anum = ano;
			m := 1;
		elsif ano > 6000 and ano < 7000 then
			select count(anum) into n from accTable_syl where anum = ano;
			m := 3;
		else
			n := 0;
			m := 0;
		end if;
		
		if n>0 then
			if m = 1 then
				open accCur1(ano);
				fetch accCur1 into now, num;
				close accCur1;
			elsif m = 2 then
				open accCur2(ano);
				fetch accCur2 into now, num;
				close accCur2;
			elsif m = 3 then
				open accCur3(ano);
				fetch accCur3 into now, num;
				close accCur3;
			end if;
			
			if num=2 then
				raise lim;
			end if;
			
			if amoun > now-500 then
				raise credit;
			elsif amoun <0 then
				raise neg;
			else
				num:=num + 1;
				now:=now - amoun;
				if m = 1 then
					update accTable_ctg@site_ctg set amount = now, withnum = num where anum = ano;
				elsif m = 2 then
					update accTable_dhk@site_dhk set amount = now, withnum = num where anum = ano;
				elsif m = 3 then
					update accTable_syl set amount = now, withnum = num where anum = ano;
				end if;
				--commit;
				DBMS_OUTPUT.PUT_LINE('Withdrawed');
			end if;
		else
			raise nouser;
		end if;
		
	exception
	
		when neg then
			DBMS_OUTPUT.PUT_LINE('Amount cannot be negative');
		when credit then
			DBMS_OUTPUT.PUT_LINE('You do not have enough credit');
		when nouser
			DBMS_OUTPUT.PUT_LINE('Account does not exists');
		when lim then
			DBMS_OUTPUT.PUT_LINE('Limitation exceeded');
		*/
	end withdraw;
	
	/*
	procedure withdrawAtm(
		atm in accTable_syl.atmno%TYPE, 
		amoun in accTable_syl.amount%TYPE)
		is
		
		i int;
		n int;
		m int; --1 for ctg, 2 for dhk, 3 for syl
		now accTable_syl.amount%TYPE;
		num accTable_ctg.withnum%TYPE;
		
		neg exception;
		credit exception;
		nouser exception;
		lim exception;
	
	begin
		m:= 0;
		i:= instr(atm, 'd');
		if i=1 then
			select count(anum) into n from accTable_dhk@site_dhk where anum = ano;
			m := 2;
		else
			i:= instr(atm, 'c');
			if i=1 then
				select count(anum) into n from accTable_ctg@site_ctg where anum = ano;
				m := 1;
			else
				select count(anum) into n from accTable_syl where anum = ano;
				m := 3;
			end if;
		end if;
		if m=0
			n := 0;
		end if;
		
		if n>0 then
			if m = 1 then
				select amount, withnum into now, num from accTable_ctg@site_ctg where anum = ano;
			elsif m = 2 then
				select amount, withnum into now, num from accTable_dhk@site_dhk where anum = ano;
			elsif m = 3 then
				select amount, withnum into now, num from accTable_syl where anum = ano;
			end if;
			
			if num=2 then
				raise lim;
			end if;
			
			if amoun > now-500 then
				raise credit;
			elsif amoun <0 then
				raise neg;
			else
				now:=now - amoun;
				if m = 1 then
					update accTable_ctg@site_ctg set amount = now where anum = ano;
				elsif m = 2 then
					update accTable_dhk@site_dhk set amount = now where anum = ano;
				elsif m = 3 then
					update accTable_syl set amount = now where anum = ano;
				end if;
				commit;
				DBMS_OUTPUT.PUT_LINE('Withdrawed');
			end if;
		else
			raise nouser;
		end if;
	
	exception
	
		when neg then
			DBMS_OUTPUT.PUT_LINE('Amount cannot be negative');
		when credit then
			DBMS_OUTPUT.PUT_LINE('You do not have enough credit');
		when nouser
			DBMS_OUTPUT.PUT_LINE('Account does not exists');
		
	end withdrawAtm;
	
	procedure deposit(
		ano in accTable_syl.anum%TYPE, 
		amoun in accTable_syl.amount%TYPE)
		
		is
		
		n int;
		m int; --1 for ctg, 2 for dhk, 3 for syl
		now accTable_syl.amount%TYPE;
		
		neg exception;
		nouser exception;
	
	begin
		if ano > 4000 and ano < 5000 then
			select count(anum) into n from accTable_dhk@site_dhk where anum = ano;
			m := 2;
		elsif ano > 5000 and ano < 6000 then
			select count(anum) into n from accTable_ctg@site_ctg where anum = ano;
			m := 1;
		elsif ano > 6000 and ano < 7000 then
			select count(anum) into n from accTable_syl where anum = ano;
			m := 3;
		else
			n := 0;
			m := 0;
		end if;
		
		if n>0 then
			if m = 1 then
				select amount into now from accTable_ctg@site_ctg where anum = ano;
			elsif m = 2 then
				select amount into now from accTable_dhk@site_dhk where anum = ano;
			elsif m = 3 then
				select amount into now from accTable_syl where anum = ano;
			end if;
			
			if amoun <0 then
				raise neg;
			else
				now:=now + amoun;
				if m = 1 then
					update accTable_ctg@site_ctg set amount = now where anum = ano;
				elsif m = 2 then
					update accTable_dhk@site_dhk set amount = now where anum = ano;
				elsif m = 3 then
					update accTable_syl set amount = now where anum = ano;
				end if;
				commit;
				DBMS_OUTPUT.PUT_LINE('Deposited');
			end if;
		else
			raise nouser;
		end if;
	
	exception
	
		when neg then
			DBMS_OUTPUT.PUT_LINE('Amount cannot be negative');
		when nouser
			DBMS_OUTPUT.PUT_LINE('Account does not exists');
		
	end deposit;
	
	procedure Transfer(
		senano in accTable_syl.anum%TYPE, 
		amoun in accTable_syl.amount%TYPE,
		recano in accTable_syl.anum%TYPE)
		
		is
		
		n int;
		m int;
		
		senderSite int;
		receiverSite int;--1 for ctg, 2 for dhk, 3 for syl
		
		nowsen accTable_dhk.amount%TYPE;
		nowrec accTable_dhk.amount%TYPE;
		
		neg exception;
		credit exception;
		nosenuser exception;
		norecuser exception;
	
	begin
		if senano > 4000 and senano <5000 then
			senderSite := 2;
			select count(anum) into n from accTable_dhk@site_dhk where anum = senano;
		elsif senano > 5000 and senano <6000 then
			senderSite := 1;
			select count(anum) into n from accTable_ctg@site_ctg where anum = senano;
		elsif senano > 6000 and senano <7000 then
			senderSite := 3;
			select count(anum) into n from accTable_syl where anum = senano;
		else
			senderSite := 0;
		end if;
		
		if recano > 4000 and recano <5000 then
			receiverSite := 2;
			select count(anum) into m from accTable_dhk@site_dhk where anum = recano;
		elsif recano > 5000 and recano <6000 then
			receiverSite := 1;
			select count(anum) into m from accTable_ctg@site_ctg where anum = recano;
		elsif recano > 6000 and recano <7000 then
			receiverSite := 3;
			select count(anum) into m from accTable_syl where anum = recano;
		else
			receiverSite := 0;
		end if;
		
		
		if n=0 then
			raise nosenuser;
		elsif m=0 then
			raise norecuser;
		else
				if senderSite = 1 then
					select amount into nowsen from accTable_ctg@site_ctg where anum = senano;
				elsif senderSite = 2 then
					select amount into nowsen from accTable_dhk@site_dhk where anum = senano;
				elsif senderSite = 3 then
					select amount into nowsen from accTable_syl where anum = senano;
				end if;
				
				if receiverSite = 1 then
					select amount into nowrec from accTable_ctg@site_ctg where anum = recano;
				elsif receiverSite = 2 then
					select amount into nowrec from accTable_dhk@site_dhk where anum = recano;
				elsif receiverSite = 3 then
					select amount into nowrec from accTable_syl where anum = recano;
				end if;
				
			if amoun > nowsen-500 then
				raise credit;
			elsif amoun <0 then
				raise neg;
			else
				nowsen:=nowsen - amoun;
				nowrec:=nowrec + amoun;
				
				if senderSite = 1 then
					update accTable_ctg@site_ctg set amount = nowsen where anum = senano;
				elsif senderSite = 2 then
					update accTable_dhk@site_dhk set amount = nowsen where anum = senano;
				elsif senderSite = 3 then
					update accTable_syl set amount = nowsen where anum = senano;
				end if;
				commit;
				
				if receiverSite = 1 then
					update accTable_ctg@site_ctg set amount = nowrec where anum = recano;
				elsif receiverSite = 2 then
					update accTable_dhk@site_dhk set amount = nowrec where anum = recano;
				elsif receiverSite = 3 then
					update accTable_syl set amount = nowrec where anum = recano;
				end if;
				commit;
				
				DBMS_OUTPUT.PUT_LINE('Transfered');
			end if;
			
		end if;
	
	exception
	
		when neg then
			DBMS_OUTPUT.PUT_LINE('Amount cannot be negative');
		when credit then
			DBMS_OUTPUT.PUT_LINE('You do not have enough credit');
		when nosenuser
			DBMS_OUTPUT.PUT_LINE('Sender Account does not exists');
		when norecuser
			DBMS_OUTPUT.PUT_LINE('Recieve Account does not exists');
		
	end transfer;
	*/
	
end Transactions;
/