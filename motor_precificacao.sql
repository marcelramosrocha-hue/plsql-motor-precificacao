-- ====================================================================
-- PROJETO: MOTOR DE PRECIFICAÇÃO DINÂMICA POR FAIXA ETÁRIA (PL/SQL)
-- AUTOR: MARCEL RAMOS DA ROCHA
-- ====================================================================

-- 1. ESTRUTURA CADASTRAL (GARANTE QUE A COLUNA EXISTE NA TABELA ORIGEM)
-- ALTER TABLE beneficiarios ADD idade NUMBER;

-- 2. PROCEDIMENTO PRINCIPAL: CALCULA E ATUALIZA A MENSALIDADE
CREATE OR REPLACE PROCEDURE PRC_FATURA_BENEFICIARIO (p_id IN NUMBER) IS
    v_idade_real NUMBER;
    v_cota_final NUMBER;
BEGIN

    -- Tarefa 1: Busca a idade do cliente na tabela cadastral
    SELECT idade INTO v_idade_real 
    FROM beneficiarios 
    WHERE id_cliente = p_id;

    -- Tarefa 2: Motor de Regras da ANS (Tomada de Decisão por Faixa Etária)
    IF v_idade_real >= 0 AND v_idade_real <= 18 THEN
        v_cota_final := 350.00;
    ELSIF v_idade_real >= 19 AND v_idade_real <= 24 THEN
        v_cota_final := 478.00;
    ELSIF v_idade_real >= 25 AND v_idade_real <= 35 THEN
        v_cota_final := 650.00;
    ELSIF v_idade_real >= 36 AND v_idade_real <= 58 THEN
        v_cota_final := 980.00;
    ELSIF v_idade_real >= 59 THEN
        v_cota_final := 2100.00;
    ELSE
        v_cota_final := 0.00;
    END IF;

    -- Tarefa 3: Grava o valor calculado dinamicamente na tabela de faturamento
    UPDATE mensalidades_beneficiarios 
    SET valor_mensalidade = v_cota_final 
    WHERE id_beneficiario = p_id;

END;
/

-- 3. EXEMPLOS DE EXECUÇÃO PRÁTICA (BOTÃO DE LIGAR O ROBÔ)
-- EXEC PRC_FATURA_BENEFICIARIO(1);  -- Processa Marcel (36 anos -> R$ 980,00)
-- EXEC PRC_FATURA_BENEFICIARIO(40); -- Processa Carlos (28 anos -> R$ 650,00)
-- EXEC PRC_FATURA_BENEFICIARIO(20); -- Processa José (61 anos -> R$ 2.100,00)

-- 4. CONSULTA DE VALIDAÇÃO DOS RESULTADOS
-- SELECT * FROM mensalidades_beneficiarios;
