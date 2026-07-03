# Motor de Precificação por Faixa Etária (PL/SQL Oracle)

Este repositório contém uma solução robusta em PL/SQL para automatizar as regras de negócio de precificação de planos de saúde com base na tabela oficial de faixas etárias. A automação processa a idade do beneficiário diretamente da base cadastral e atualiza dinamicamente a tabela de faturamento de mensalidades.

# Desafios de Engenharia de Dados Resolvidos
Durante a fase de testes unitários e homologação, o script foi calibrado para tratar inconsistências comuns em ambientes de produção:
1. **Tratamento de Estrutura Ausente (ORA-00904):** Identificada a ausência da coluna idade na tabela de origem. Mitigado através de alteração estrutural controlada (ALTER TABLE).
2. **Consistência de Busca (ORA-01403 - No Data Found):** Implementada a consistência física de chaves. O motor agora valida a existência prévia do registro na tabela de faturamento antes de efetuar o processamento do bloco lógico.

# Matriz de Regras e Resultados Práticos
O motor valida os dados cruzando faixas etárias com os valores de cota definidos:

- **Faixa 1 (0 a 18 anos):** R$ 350,00
- **Faixa 2 (19 a 24 anos):** R$ 478,00
- **Faixa 3 (25 a 35 anos):** R$ 650,00 -> *Testado com Sucesso: ID 40 (Carlos)*
- **Faixa 4 (36 a 58 anos):** R$ 980,00 -> *Testado com Sucesso: ID 1 (Marcel)*
- **Faixa 5 (Acima de 59):** R$ 2.100,00 -> *Testado com Sucesso: ID 20 (José)*
