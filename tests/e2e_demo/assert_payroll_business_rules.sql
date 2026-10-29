-- A singular data test returns failing rows; zero rows means PASS.
select * from {{ ref('fact_payroll') }}
where not is_deleted and (
 payroll_id <= 0 or employee_id <= 0 or net_pay < 0
 or base_pay <= 0 or bonus < 0 or deductions < 0
 or abs(net_pay - (base_pay + bonus - deductions)) > 0.01
 or net_pay is null or base_pay is null or bonus is null or deductions is null
)
