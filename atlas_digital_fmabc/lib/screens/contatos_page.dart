import 'package:flutter/material.dart';

class ContatosPage extends StatelessWidget {
  const ContatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // layout
      appBar: _savedAppBar(context),
      // conteúdo
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700; // ponto de quebra

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _emailsSection(theme)),
                      const SizedBox(width: 20),
                      Expanded(child: _phonesSection(theme)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _emailsSection(theme),
                      const SizedBox(height: 32),
                      _phonesSection(theme),
                    ],
                  ),
          );
        },
      ),
    );
  }

 AppBar _savedAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      // aparência
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      // título da página
      title: Text(
        "Atlas Digital",
        style: theme.textTheme.headlineMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _emailsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("E-mails de contato", theme),
        const SizedBox(height: 12),
        _roundedCard(
          children: const [
            _ContactRow(label: "Secretaria:", value: "exemplosecretaria@fmabc.br"),
            _ContactRow(label: "Coordenação:", value: "exemplocoordenacao@fmabc.br"),
            _ContactRow(label: "Suporte:", value: "exemplosuporte@fmabc.br"),
          ],
        ),
      ],
    );
  }

  Widget _phonesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Telefones", theme),
        const SizedBox(height: 12),
        _roundedCard(
          children: const [
            _ContactRow(label: "Secretaria:", value: "(11) 99999-9999"),
            _ContactRow(label: "Coordenação:", value: "(11) 88888-8888"),
            _ContactRow(label: "Suporte:", value: "(11) 77777-7777"),
          ],
        ),
      ],
    );
  }

  Widget _sectionTitle(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _roundedCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              const Divider(height: 18, thickness: .8),
          ]
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String label;
  final String value;

  const _ContactRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}