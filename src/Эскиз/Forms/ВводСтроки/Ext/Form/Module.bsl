﻿
&НаКлиенте
Процедура ПрименитьСписокВыбора(Команда)
	Закрыть(Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьИЗакрыть(Команда)
	Закрыть();
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Заголовок = Параметры.Заголовок;
	Значение = Параметры.Значение;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Элементы.Значение.УстановитьГраницыВыделения(1, СтрДлина(Значение) + 1);

КонецПроцедуры
