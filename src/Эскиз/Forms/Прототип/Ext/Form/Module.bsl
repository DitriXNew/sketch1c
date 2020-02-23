﻿
&НаКлиенте
Процедура АктивизироватьТекущийЭлементУправления(ИмяЭлемента) Экспорт
	ИскомыйЭлемент = ЭтаФорма.Элементы.Найти(ИмяЭлемента);
	Если ИскомыйЭлемент = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЭтотОбъект.ТекущийЭлемент = ИскомыйЭлемент;
	ЭтотОбъект.ОбновитьОтображениеДанных();
	
КонецПроцедуры

&НаКлиенте
Процедура НарисоватьЭлементУправления(Тип, СпециальныеСвойства, ТиповыеСвойства, Связать, Перемещение) Экспорт
	НарисоватьЭлементУправленияНаСервере(Тип, СпециальныеСвойства, ТиповыеСвойства, Связать, Перемещение);
	ЭтаФорма.ОбновитьОтображениеДанных();
	
КонецПроцедуры

&НаСервере
Процедура НарисоватьЭлементУправленияНаСервере(Тип, СпециальныеСвойства, ТиповыеСвойства, Связать, Перемещение)
	РодительЭлемента = СпециальныеСвойства.Родитель;
	Если ПустаяСтрока(РодительЭлемента) Тогда
		РодительЭлемента = Неопределено;
		
	Иначе
		РодительЭлемента = ЭтаФорма.Элементы[РодительЭлемента];
		
	КонецЕсли;
	
	Если Перемещение Тогда
		Элемент = СпециальныеСвойства.Элемент;
		Если ЗначениеЗаполнено(Элемент) Тогда
			Элемент =  ЭтаФорма.Элементы[Элемент];
			
		КонецЕсли;
		
		НовыйЭлемент = Этаформа.Элементы.Вставить(СпециальныеСвойства.Имя, Тип, РодительЭлемента, Элемент);
		
	Иначе
		НовыйЭлемент = Этаформа.Элементы.Добавить(СпециальныеСвойства.Имя, Тип, РодительЭлемента);
		
	КонецЕсли;
	
	Если Тип = Тип("КнопкаФормы") Тогда
		Если Связать Тогда
			ДобавитьКоманду(СпециальныеСвойства.Имя, "ОбработатьКоманду", ТиповыеСвойства.Заголовок);
			
		КонецЕсли;
		
		НовыйЭлемент.ИмяКоманды = СпециальныеСвойства.Имя;
		НовыйЭлемент.Вид = ВидКнопкиФормы[СпециальныеСвойства.Вид];
		
	ИначеЕсли Тип = Тип("ПолеФормы") Тогда
		Если Связать Тогда
			СоздатьИзменитьРеквизитНаСервере(СпециальныеСвойства);
			
		КонецЕсли;
		
		НовыйЭлемент.Вид = ВидПоляФормы[СпециальныеСвойства.Вид];
		НовыйЭлемент.ПутьКДанным = СпециальныеСвойства.ПутьКДанным;
		
		Если НовыйЭлемент.Вид = ВидПоляФормы.ПолеКартинки Тогда
			НовыйЭлемент.Рамка = Новый Рамка(ТипРамкиЭлементаУправления.БезРамки);
			НовыйЭлемент.УстановитьДействие("Нажатие", "ОбработатьНажатие");
			ДобавитьКоманду(СпециальныеСвойства.Имя, "ОбработатьКоманду", ТиповыеСвойства.Заголовок);
			
		КонецЕсли;
	ИначеЕсли Тип = Тип("ГруппаФормы") Тогда
		НовыйЭлемент.Вид = ВидГруппыФормы[СпециальныеСвойства.Вид];

	ИначеЕсли Тип = Тип("ТаблицаФормы") Тогда
		Если Связать Тогда
			СоздатьИзменитьРеквизитНаСервере(СпециальныеСвойства);
			
		КонецЕсли;
		
		НовыйЭлемент.ПутьКДанным = СпециальныеСвойства.Имя;
		
	ИначеЕсли Тип = Тип("ДекорацияФормы") Тогда
		НовыйЭлемент.Вид = ВидДекорацииФормы[СпециальныеСвойства.Вид];
		
	КонецЕсли;
	
	Для Каждого Пара Из ТиповыеСвойства Цикл
		УстановитьИзменитьСвойство(НовыйЭлемент, Пара.Ключ, Пара.Значение);
		
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Функция СтеретьЭлементУправления(ИмяЭлемента, ИмяРеквизита, ЭтоКоманда, ЭтоКолонка, ИмяТаблицы) Экспорт
	Результат = СтеретьЭлементУправленияНаСервере(ИмяЭлемента, ИмяРеквизита, ЭтоКоманда, ЭтоКолонка, ИмяТаблицы);
	ЭтаФорма.ОбновитьОтображениеДанных();
	
	Возврат Результат;
КонецФункции

&НаСервере
Функция СтеретьЭлементУправленияНаСервере(ИмяЭлемента, ИмяРеквизита, ЭтоКоманда, ЭтоКолонка, ИмяТаблицы)
	Результат = Ложь;
	
	ИскомыйЭлемент = ЭтаФорма.Элементы.Найти(ИмяЭлемента);
	Если ИскомыйЭлемент = Неопределено Тогда
		Возврат Результат;
	КонецЕсли;
	
	ЭтаФорма.Элементы.Удалить(ИскомыйЭлемент);
	
	Если ПустаяСтрока(ИмяРеквизита) Тогда
		Результат = Истина;
		
		Возврат Результат;
	КонецЕсли;
	
	Если ЭтоКоманда Тогда
		ИскомаяКоманда = ЭтаФорма.Команды.Найти(ИмяРеквизита);
		Если ИскомаяКоманда = Неопределено Тогда
			//todo
		Иначе
			ЭтаФорма.Команды.Удалить(ИскомаяКоманда);
			
			Результат = Истина;
			
		КонецЕсли;
	ИначеЕсли ЭтоКолонка Тогда
		УдаляемыеРеквизиты = Новый Массив(1);
		УдаляемыеРеквизиты[0] = ИмяТаблицы + "." + ИмяРеквизита;
		
		ИзменитьРеквизиты(, УдаляемыеРеквизиты);
		
		Результат = Истина;
		
	Иначе
		УдаляемыеРеквизиты = Новый Массив(1);
		УдаляемыеРеквизиты[0] = ИмяРеквизита;
		
		ИзменитьРеквизиты(, УдаляемыеРеквизиты);
		
		Результат = Истина;
		
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура ПереместитьЭлементУправления(ДанныеПеремещения) Экспорт
	ПереместитьЭлементУправленияНаСервере(ДанныеПеремещения);
	ЭтаФорма.ОбновитьОтображениеДанных();
	
КонецПроцедуры

&НаСервере
Процедура ПереместитьЭлементУправленияНаСервере(ДанныеПеремещения)
	ПеремещаемыйЭлемент = Элементы.Найти(ДанныеПеремещения.ИмяПеремещаемогоЭлемента);
	
	Если ПустаяСтрока(ДанныеПеремещения.ИмяРодительскогоЭлемента) Тогда
		РодительскийЭлемент = ЭтотОбъект;
		
	Иначе
		РодительскийЭлемент = Элементы.Найти(ДанныеПеремещения.ИмяРодительскогоЭлемента);
		
	КонецЕсли;
	
	Если ПустаяСтрока(ДанныеПеремещения.ИмяЭлементаМесторасположения) Тогда
		ЭлементМестоположения = Неопределено;
		
	Иначе
		ЭлементМестоположения = Элементы.Найти(ДанныеПеремещения.ИмяЭлементаМесторасположения);
		
	КонецЕсли;

	Элементы.Переместить(ПеремещаемыйЭлемент, РодительскийЭлемент, ЭлементМестоположения);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьСвойствоЭлементаУправления(Свойство, Значение, ЭтоФорма, ИмяЭлемента) Экспорт
	ИзменитьСвойствоЭлементаУправленияНаСервере(Свойство, Значение, ЭтоФорма, ИмяЭлемента);
	ЭтаФорма.ОбновитьОтображениеДанных();
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьСвойствоЭлементаУправленияНаСервере(Свойство, Значение, ЭтоФорма, ИмяЭлемента)
	ИскомыйЭлемент = Неопределено;
	Если ЭтоФорма Тогда
		ИскомыйЭлемент = ЭтаФорма;
		
	Иначе
		ИскомыйЭлемент = ЭтаФорма.Элементы.Найти(ИмяЭлемента);
		
	КонецЕсли;
	
	Если ИскомыйЭлемент = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьИзменитьСвойство(ИскомыйЭлемент, Свойство, Значение);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьИзменитьСвойство(ИскомыйЭлемент, Свойство, Значение)
	Если Свойство = "Группировка" Тогда
		Если ИскомыйЭлемент.Вид = ВидГруппыФормы.ГруппаКолонок Тогда
			ИскомыйЭлемент[Свойство] = ГруппировкаКолонок[Значение];
			
		Иначе
			ИскомыйЭлемент[Свойство] = ГруппировкаПодчиненныхЭлементовФормы[Значение];
			
		КонецЕсли;
	ИначеЕсли Свойство = "ОтображатьЗаголовок" Тогда
		ИскомыйЭлемент[Свойство] = Значение = "Да";
		
	ИначеЕсли Свойство = "Отображение" Тогда
		Если ИскомыйЭлемент.Вид = ВидГруппыФормы.ГруппаКнопок Тогда
			ИскомыйЭлемент[Свойство] = ОтображениеГруппыКнопок[Значение];
			
		Иначе
			ИскомыйЭлемент[Свойство] = ОтображениеКнопки[Значение];
			
		КонецЕсли;
	ИначеЕсли Свойство = "ОтображениеПодсказки" Тогда
		ИскомыйЭлемент.ОтображениеПодсказки = ОтображениеПодсказки[Значение];
		
	ИначеЕсли Свойство = "ВидПереключателя" Тогда
		ИскомыйЭлемент[Свойство] = ВидПереключателя[Значение];
		
	ИначеЕсли Свойство = "ПоложениеЗаголовка" Тогда
		ИскомыйЭлемент[Свойство] = ПоложениеЗаголовкаЭлементаФормы[Значение];
		
	ИначеЕсли Свойство = "СписокВыбора" Тогда
		ИскомыйЭлемент[Свойство].ЗагрузитьЗначения(Значение.ВыгрузитьЗначения());
		
	ИначеЕсли Свойство = "Картинка" Или Свойство = "КартинкаЗначений" Тогда
		Если Не ПустаяСтрока(Значение) Тогда
			ИскомыйЭлемент[Свойство] = БиблиотекаКартинок[Значение];
			
		КонецЕсли;
	ИначеЕсли Свойство = "ГоризонтальноеПоложениеПодчиненных" Тогда
		ИскомыйЭлемент[Свойство] = ГоризонтальноеПоложениеЭлемента[Значение];
		
	ИначеЕсли Свойство = "ВертикальноеПоложениеПодчиненных" Тогда
		ИскомыйЭлемент[Свойство] = ВертикальноеПоложениеЭлемента[Значение];
		
	ИначеЕсли Свойство = "ГоризонтальноеПоложениеВГруппе" Тогда
		ИскомыйЭлемент[Свойство] = ГоризонтальноеПоложениеЭлемента[Значение];
		
	ИначеЕсли Свойство = "ВертикальноеПоложениеВГруппе" Тогда
		ИскомыйЭлемент[Свойство] = ВертикальноеПоложениеЭлемента[Значение];
		
	ИначеЕсли Свойство = "ВидФлажка" Тогда
		ИскомыйЭлемент[Свойство] = ВидФлажка[Значение];
		
	ИначеЕсли Свойство = "ЦветФона" Или Свойство = "ЦветТекста" Или Свойство = "ЦветРамки" Тогда
		Если ЗначениеЗаполнено(Значение) Тогда
			ИскомыйЭлемент[Свойство] = ВычислитьЦвет(Значение);
			
		Иначе
			ИскомыйЭлемент[Свойство] = Новый Цвет();
			
		КонецЕсли;
	ИначеЕсли Свойство = "СквозноеВыравнивание" Тогда
		ИскомыйЭлемент[Свойство] = СквозноеВыравнивание[Значение];
		
	ИначеЕсли Свойство = "Шрифт" Тогда
		ИскомыйЭлемент[Свойство] = Новый Шрифт();
		
	Иначе
		ИскомыйЭлемент[Свойство] = Значение;
		
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВычислитьЦвет(Значение) 
	Возврат Вычислить(Значение);
КонецФункции

&НаКлиенте
Процедура СоздатьИзменитьРеквизит(СпециальныеСвойства) Экспорт
	СоздатьИзменитьРеквизитНаСервере(СпециальныеСвойства);

КонецПроцедуры

&НаСервере
Процедура СоздатьИзменитьРеквизитНаСервере(СпециальныеСвойства)
	ДобавляемыеРеквизиты = Новый Массив(1);
	УдаляемыеРеквизиты = Новый Массив(1);
	
	Если СпециальныеСвойства.ТипЗначения = "Строка" Тогда
		КС = Новый КвалификаторыСтроки(СпециальныеСвойства.Длина);
		ТипЗначения = Новый ОписаниеТипов(СпециальныеСвойства.ТипЗначения,, КС);
		
	ИначеЕсли СпециальныеСвойства.ТипЗначения = "Число" Тогда
		КЧ = Новый КвалификаторыЧисла(СпециальныеСвойства.Длина, СпециальныеСвойства.Точность);
		ТипЗначения = Новый ОписаниеТипов(СпециальныеСвойства.ТипЗначения, КЧ);
		
	ИначеЕсли СпециальныеСвойства.ТипЗначения = "Дата" Тогда
		КД = Новый КвалификаторыДаты(ЧастиДаты[СпециальныеСвойства.СоставДаты]);
		ТипЗначения = Новый ОписаниеТипов(СпециальныеСвойства.ТипЗначения,,, КД);
		
	Иначе
		ТипЗначения = Новый ОписаниеТипов(СпециальныеСвойства.ТипЗначения);
		
	КонецЕсли;

	ЭтоНовыйРеквизит = Истина;
	
	ИскомыйРеквизит = НайтиРеквизитПоИмени(СпециальныеСвойства.Имя, СпециальныеСвойства.Путь);
	Если ИскомыйРеквизит = Неопределено Тогда
		ИскомыйРеквизит = Новый РеквизитФормы(СпециальныеСвойства.Имя, ТипЗначения, СпециальныеСвойства.Путь);
		
	Иначе
		ЭтоНовыйРеквизит = Ложь;
		
		ИскомыйРеквизит.ТипЗначения = ТипЗначения;
		
	КонецЕсли;

	ДобавляемыеРеквизиты[0] = ИскомыйРеквизит;
	
	Если ЭтоНовыйРеквизит Тогда
		ИзменитьРеквизиты(ДобавляемыеРеквизиты);
		
	Иначе
		Если ПустаяСтрока(СпециальныеСвойства.Путь) Тогда
			УдаляемыеРеквизиты[0] = СпециальныеСвойства.Имя;
			
		Иначе
			УдаляемыеРеквизиты[0] = СпециальныеСвойства.Путь + "." + СпециальныеСвойства.Имя;
			
		КонецЕсли;
		
		ИзменитьРеквизиты(ДобавляемыеРеквизиты, УдаляемыеРеквизиты);
		
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция НайтиРеквизитПоИмени(ИскомоеИмя, Путь)
	Результат = Неопределено;
	
	ВсеРеквизиты = ЭтаФорма.ПолучитьРеквизиты(Путь);
	Для Каждого Реквизит Из ВсеРеквизиты Цикл
		Если Реквизит.Имя = ИскомоеИмя Тогда
			Результат = Реквизит;
			
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

&НаСервере
Процедура ДобавитьКоманду(ИмяКоманды, Действие, Заголовок)
	НоваяКоманда = ЭтаФорма.Команды.Добавить(ИмяКоманды);
	НоваяКоманда.Действие = Действие;
	НоваяКоманда.Заголовок = Заголовок;
	НоваяКоманда.Отображение = ОтображениеКнопки.Текст;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьКоманду(Команда)
	////Сообщить(Команда.Имя);
	//
	//ЭтотОбъект.ФорматированнаяСтрока1 = Новый ФорматированнаяСтрока("Товар ", Новый ФорматированнаяСтрока("Телевизор", ,
	//WebЦвета.Красный, , "СсылкаНаТовар"), " отсутствует на складе"); 
	////ПодключитьОбработчикОжидания("Прогресс", 1, Истина);
	//
КонецПроцедуры

&НаКлиенте
Процедура Прогресс() Экспорт
	Если ЭтотОбъект.Индикатор1 < 100 Тогда
		ЭтотОбъект.Индикатор1 = ЭтотОбъект.Индикатор1 + 10;
		
		ПодключитьОбработчикОжидания("Прогресс", 1, Истина);
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьНажатие(Элемент, СтандартнаяОбработка)
	//СтандартнаяОбработка = Ложь;
	//
	//ЗагрузитьКартинку(Элемент.Имя);
	//
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьКартинку(ИмяРеквизита)
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	ПараметрыЗагрузкиКартинки = Новый Структура;
	ПараметрыЗагрузкиКартинки.Вставить("ИмяРеквизита", ИмяРеквизита);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗагрузитьКартинкуПродолжение", ЭтотОбъект, ПараметрыЗагрузкиКартинки);
	
	ДиалогВыбораФайла.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьКартинкуПродолжение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	ОписаниеОповещенияОЗавершении = Новый ОписаниеОповещения("ЗагрузитьКартинкуЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	НачатьПомещениеФайла(ОписаниеОповещенияОЗавершении, , , , ВыбранныеФайлы[0]);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьКартинкуЗавершение(ОписаниеПомещенногоФайла, ДополнительныеПараметры) Экспорт
	ЭтотОбъект[ДополнительныеПараметры.ИмяРеквизита] = ОписаниеПомещенногоФайла.Адрес;
	
КонецПроцедуры

&НаКлиенте
Процедура ЭмулироватьПрогресс() Экспорт
	ТекущийЭлемент = Неопределено;
	
КонецПроцедуры
