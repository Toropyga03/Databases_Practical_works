skillbox=# EXPLAIN
SELECT t.task_name, u.username
FROM tasks t
JOIN users u ON t.author_id = u.user_id
WHERE t.task_id < 10;
                              QUERY PLAN
-----------------------------------------------------------------------
 Hash Join  (cost=12.34..24.73 rows=47 width=1032)
   Hash Cond: (u.user_id = t.author_id)
   ->  Seq Scan on users u  (cost=0.00..11.40 rows=140 width=520)
   ->  Hash  (cost=11.75..11.75 rows=47 width=520)
         ->  Seq Scan on tasks t  (cost=0.00..11.75 rows=47 width=520)
               Filter: (task_id < 10)
(6 rows)

Анализ:
Запрос использует хеш-соединение (Hash Join)
Для таблицы users выполняется полное сканирование (Seq Scan)
Для таблицы tasks также выполняется полное сканирование с фильтрацией по условию task_id < 10
Индексы не используются (нет Index Scan в плане выполнения)
Ожидается обработка 47 строк из таблицы tasks и 140 строк из таблицы users
--===========================================================================================

skillbox=# EXPLAIN
 SELECT m.manager_name, COUNT(u.user_id)
 FROM managers m
 JOIN users u ON m.manager_id = u.manager_id
 GROUP BY m.manager_name;
                                   QUERY PLAN
---------------------------------------------------------------------------------
 HashAggregate  (cost=25.63..27.03 rows=140 width=524)
   Group Key: m.manager_name
   ->  Hash Join  (cost=13.15..24.93 rows=140 width=520)
         Hash Cond: (u.manager_id = m.manager_id)
         ->  Seq Scan on users u  (cost=0.00..11.40 rows=140 width=8)
         ->  Hash  (cost=11.40..11.40 rows=140 width=520)
               ->  Seq Scan on managers m  (cost=0.00..11.40 rows=140 width=520)
(7 rows)

Анализ:
Группировка выполняется с помощью HashAggregate
Соединение таблиц выполняется через Hash Join
Для обеих таблиц (users и managers) используется полное сканирование (Seq Scan)
Индексы не задействованы
Ожидается обработка 140 строк из каждой таблицы
--============================================================================================

skillbox=# EXPLAIN ANALYZE SELECT ug.user_id, g.group_name
 FROM user_group ug
 JOIN groups g ON ug.group_id = g.group_id
 WHERE g.group_name = 'Development';
                                                               QUERY PLAN
----------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=25.25..44.05 rows=16 width=520) (actual time=0.042..0.044 rows=0 loops=1)
   ->  Index Scan using groups_group_name_key on groups g  (cost=0.14..8.16 rows=1 width=520) (actual time=0.041..0.041 rows=0 loops=1)
         Index Cond: ((group_name)::text = 'Development'::text)
   ->  Bitmap Heap Scan on user_group ug  (cost=25.11..35.78 rows=11 width=8) (never executed)
         Recheck Cond: (group_id = g.group_id)
         ->  Bitmap Index Scan on user_group_pkey  (cost=0.00..25.11 rows=11 width=0) (never executed)
               Index Cond: (group_id = g.group_id)
 Planning Time: 0.577 ms
 Execution Time: 0.159 ms
(9 rows)

Анализ:
Запрос использует вложенный цикл (Nested Loop)
Для таблицы groups выполняется Index Scan по индексу groups_group_name_key (используется индекс)
Для таблицы user_group планировалось выполнить Bitmap Heap Scan с использованием индекса user_group_pkey,
но операция не выполнена (never executed), так как в таблице groups не найдено строк с group_name = 'Development'
Фактически возвращено 0 строк
Время выполнения очень мало - 0.159 мс
--=============================================================================================

Общие выводы:
В первых двух запросах не используются индексы (только Seq Scan)
В третьем запросе эффективно используется индекс для поиска по group_name
В третьем запросе видна оптимизация выполнения - часть плана не выполняется, когда нет подходящих строк
Индекс используется эффективно
Запрос быстро отработал (Execution Time: 0.159 ms).

