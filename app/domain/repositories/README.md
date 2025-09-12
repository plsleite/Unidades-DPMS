# Repository Interfaces

Este diretório contém as interfaces dos repositórios, definindo os contratos para acesso a dados sem acoplar o domínio à infraestrutura.

## Interfaces Principais

### IUnidadeRepository
Contrato para operações com unidades

```javascript
interface IUnidadeRepository {
  findById(id: number): Promise<Unidade | null>;
  findAll(): Promise<Unidade[]>;
  findByRegional(regionalId: number): Promise<Unidade[]>;
  save(unidade: Unidade): Promise<Unidade>;
  update(unidade: Unidade): Promise<Unidade>;
  delete(id: number): Promise<void>;
}
```

### IDefensoriaRepository
Contrato para operações com defensorias

```javascript
interface IDefensoriaRepository {
  findById(id: number): Promise<Defensoria | null>;
  findByUnidade(unidadeId: number): Promise<Defensoria[]>;
  findVagas(): Promise<Defensoria[]>;
  findAfastadas(): Promise<Defensoria[]>;
  save(defensoria: Defensoria): Promise<Defensoria>;
  update(defensoria: Defensoria): Promise<Defensoria>;
  delete(id: number): Promise<void>;
}
```

### IRegionalRepository
Contrato para operações com regionais

```javascript
interface IRegionalRepository {
  findById(id: number): Promise<Regional | null>;
  findAll(): Promise<Regional[]>;
  findByNumero(numero: number): Promise<Regional | null>;
  save(regional: Regional): Promise<Regional>;
  update(regional: Regional): Promise<Regional>;
  delete(id: number): Promise<void>;
}
```

### ICoordenacaoRepository
Contrato para operações com coordenações

```javascript
interface ICoordenacaoRepository {
  findByUnidade(unidadeId: number): Promise<Coordenacao[]>;
  findByTipo(unidadeId: number, tipo: string): Promise<Coordenacao | null>;
  save(coordenacao: Coordenacao): Promise<Coordenacao>;
  update(coordenacao: Coordenacao): Promise<Coordenacao>;
  delete(id: number): Promise<void>;
}
```

## Princípios

1. **Inversão de Dependência**: Domínio define contratos, infraestrutura implementa
2. **Abstração**: Interfaces não expõem detalhes de implementação
3. **Testabilidade**: Fácil criação de mocks para testes
4. **Flexibilidade**: Permite trocar implementações sem afetar domínio
