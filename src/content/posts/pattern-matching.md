+++
title = "Pattern Matching"
date = "2019-06-21T00:00:07"
+++
در قسمت قبلی وارد shell ارلنگ شدیم و فهمیدیم همه چیز در ارلنگ عبارت یا Expression هست. در این قسمت نگاه بهتری به متغیر ها در ارلنگ میندازیم و با توضیح مختصری از ساختمان های داده، تطبیق الگو یا pattern matching رو بهتر یاد میگیریم.  
اسم متغیر ها در ارلنگ با حروف بزرگ انگلیسی شروع میشه. به جز اولین کاراکتر، بقیه ی کارکتر های اسم متغیر میتونن حروف بزرگ یا کوچک انگلیسی و یا اعداد انگیسی و یا کاراکتر _ باشن.  

{{< highlight erlang >}}
1> A = 10.
10

2> B = 10.
10

3> A + B.
20

4> A = B = 10.
10

5> A = C = B = 10.
10

6> C.
10

7> A_and_B_and_C = A + B + C.
30

8> A_and_B_and_C.
30
{{< / highlight >}}

همچنین میتونیم اسم متغیر هارو با کاراکتر _ شروع کنیم. ولی از اونجایی که کامپایلر ارلنگ رفتار خاصی در برابر این نوع متغیر ها انجام میده، فعلا به توضیح و تفصیرش نمیپردازم.

{{< highlight erlang >}}
9> _Var = 10.
10

10> _var = 6.
6

11> _var + _Var.
16
{{< / highlight >}}

همونطور که میبینید در ارلنگ هم مثل خیلی از زبان های دیگه کوچک و بزرگ بودن حروف در اسم متغیر ها مهم هست و برای مثال متغیر های _A و _a دو متغیر جدا از هم هستند. اصطلاحا به این ویژگی  [case sentitivity](https://en.wikipedia.org/wiki/Case_sensitivity) گفته میشه.  
همچنین اگر قراره از متغیری استفاده کنید، نمیتونید اسمش رو فقط _ بذارید. در ارلنگ به _ اصطلاحا متغیر بی‌نام یا anonymous variable گفته میشه. برای مثال شما میتونید از این متغیر در پترن مچینگ استفاده کنید ولی برای دسترسی به داده ای که درش ذخیره کردید نمیتونید ازش استفاده کنید چون اصلا داده ای درش ذخیره نمیشه ! ممکنه سوال پیش بیاد که اگر نمیشه درش داده ذخیره کرد، پس اصلا به چه کاری میاد؟ خوب تا پایان این بخش به پاسخ این سوال میرسیم.  


در ادامه این بخش، بصورت مختصر چند ساختمان داده در ارلنگ رو یاد میگیریم و با کمک اونها پترن مچینگ رو بهتر یاد میگیریم. هدف از معرفی این ساختمان های داده صرفا درک بهتر پترن مچینگ هست و بعدا بطور مفصل تری خواص این ساختمان های داده رو بررسی میکنیم.  

![pattern-matching](/posts/images/erlang-fa.ir-pattern-matching-01.jpg)



## List ساختمان داده
لیست یا همون آرایه معروف خودمون! یک نوع ساختمان داده مرکب برای نگهداری ساختمان های داده دیگر و یا برای نگه داشتن هیچ چیزی (اگر خالی در نظر بگیریمش). در ارلنگ لیست ها با کاراکتر ] شروع و با [ بسته میشن. همچنین برای تفکیک اعضای لیست، از کاراکتر , یا کاما استفاده میکنیم.

{{< highlight erlang >}}
1> [1,2,3,4,5].
[1,2,3,4,5]

2> [].
[]

3> A = [3.14].
[3.14]

4> A.
[3.14]

5> B = [1,2,3,A].
[1,2,3,[3.14]]
{{< / highlight >}}

در این بخش قرار نیست کل خصوصیات لیست هارو باد بگیریم. این موارد در بخش مخصوص به لیست ها بزودی آموزش داده میشن. علت معرفی لیست ها در اینجا، یادگیری بهتر پترن مچینگ هست:

{{< highlight erlang >}}
1> MyList = [1,2,3.14].
[1,2,3.14]

2> MyList.
[1,2,3.14]

3> [One, Two, Pi] = MyList.
[1,2,3.14]

4> One + Two.
3

5> Pi.
3.14

6> [First, _, Last] = MyList.
[1,2,3.14]

7> First.
1

8> Last.
3.14
{{< / highlight >}}

حالا فهمیدین متغیر _ به چه کاری میاد؟

![i-got-it](/posts/images/erlang-fa.ir-pattern-matching-02.png)

## Tuple ساختمان داده
یک ساختمان داده مرکب برای ذخیره سازی ساختمان داده های دیگر. فرقش با لیست اینه تعداد اعضای لیست ها ممکنه در طول زمان تغییر کنه و به همین منظور هم ساخته شده. اما تاپل ها معمولا جایی استفاده میشن که تعداد اعضاشون تغییر نکنه و به اصطلاح fixed size هستند. در ارلنگ تاپل ها با کاراکتر } شروع میشن و با کاراکتر { هم بسته میشن و همچنین برای تفکیک اعضای تاپل از کاراکتر , یا کاما استفاده میکنیم.

{{< highlight erlang >}}
1> MyTuple = {1,2,3.14}.
{1,2,3.14}

2> {First, _, Pi} = {_, Two, _} = MyTuple.
{1,2,3.14}

3> First + Two.
3

4> Pi.
3.14
{{< / highlight >}}

ممکنه کلی سوال از ساختمان داده تاپل یا لیست در ذهنتون باشه. اما در زمان درست همشون رو جواب میدم. فعلا وظیفه خودم میدونم توی مغزتون جا بندازم که در ارلنگ عملگر = وظیفش پترن مچینگ هست و نه فقط تعریف متغیر. حالا میتونیم پترن های پیچیده تری رو تست کنیم:

{{< highlight erlang >}}
1> Data = [{1, [2, {3.14}]}].
[{1,[2,{3.14}]}]

2> [{One, _}] = Data.
[{1,[2,{3.14}]}]

3> One.
1

4> [{_, [Two, _]}] = Data.
[{1,[2,{3.14}]}]

5> Two.
2

6> [{_, [_, {Pi}]}] = Data.
[{1,[2,{3.14}]}]

7> Pi.
3.14
{{< / highlight >}}

هدف اصلی پترن مچینگ سادگیست. در قسمت بعد این سادگی رو بهتر و بیشتر حس میکنید. ارلنگ هم مثل بقیه ی زبان ها این امکان رو به شما میده که کد های برنامه‌نویسی رو در یک فایل بنویسید و کامپایل کنید و سپس اجراش کنید. در قسمت بعدی قراره یاد بگیریم چطور توی فایل کد بزنیم و چند نمونه ساده از پیاده سازی تابع در ارلنگ هم یاد میگیریم.
