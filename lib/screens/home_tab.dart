import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/cwe_logo.dart';
import '../widgets/product_card.dart';

// Pestaña Inicio, buscador, filtro y cuadrícula de productos
// son correcciones de los errores E-07 y E-08.

class HomeTab extends StatefulWidget {
  final void Function(Product product) onAdd;

  const HomeTab({super.key, required this.onAdd});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _searchController = TextEditingController();
  String _query = '';
  String _provider = 'Todos';
  String _category = 'Todas';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filtered {
    final q = normalizeText(_query.trim());
    return sampleProducts.where((p) {
      final matchesQuery = q.isEmpty ||
          normalizeText(p.name).contains(q) ||
          normalizeText(p.provider).contains(q) ||
          normalizeText(p.category).contains(q);
      final matchesProvider = _provider == 'Todos' || p.provider == _provider;
      final matchesCategory =
          _category == 'Todas' || normalizeText(p.category) == normalizeText(_category);
      return matchesQuery && matchesProvider && matchesCategory;
    }).toList();
  }

  int get _activeFilters =>
      (_provider != 'Todos' ? 1 : 0) + (_category != 'Todas' ? 1 : 0);

  void _clearAll() {
    _searchController.clear();
    setState(() {
      _query = '';
      _provider = 'Todos';
      _category = 'Todas';
    });
  }

  Future<void> _openFilters() async {
    var provider = _provider;
    var category = _category;
    final providers = ['Todos', ...{for (final p in sampleProducts) p.provider}];
    final categoryOptions = categories;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filtrar productos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ChipGroup(
                    title: 'Proveedor',
                    options: providers,
                    selected: provider,
                    onSelected: (v) => setSheetState(() => provider = v),
                  ),
                  const SizedBox(height: 16),
                  _ChipGroup(
                    title: 'Categoría',
                    options: categoryOptions,
                    selected: category,
                    onSelected: (v) => setSheetState(() => category = v),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => setSheetState(() {
                            provider = 'Todos';
                            category = 'Todas';
                          }),
                          child: const Text('Limpiar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cyan,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _provider = provider;
                              _category = category;
                            });
                            Navigator.pop(sheetContext);
                          },
                          child: const Text('Aplicar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: banner horizontal "Conecta con la tierra" (imagen #3).
        const _HeaderBanner(),
        // Buscador y filtros
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _query = value),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Buscar productos...',
                        hintStyle:
                            const TextStyle(color: Colors.white54, fontSize: 14),
                        prefixIcon: const Icon(Icons.search,
                            color: Colors.white54, size: 20),
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white54, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _query = '');
                                },
                              ),
                        filled: true,
                        fillColor: AppColors.surface,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              const BorderSide(color: AppColors.cyan, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: _openFilters,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 46,
                      width: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Badge(
                        isLabelVisible: _activeFilters > 0,
                        backgroundColor: AppColors.cyan,
                        textColor: Colors.black,
                        label: Text('$_activeFilters'),
                        child: const Icon(Icons.filter_list,
                            color: AppColors.cyan, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Chips de categoría horizontales (filtro rápido y visible).
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final selected = _category == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: selected,
                selectedColor: AppColors.cyan,
                backgroundColor: AppColors.surface,
                side: BorderSide(
                  color: selected ? AppColors.cyan : AppColors.border,
                ),
                labelStyle: TextStyle(
                  color: selected ? Colors.black : Colors.white,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
                showCheckmark: false,
                onSelected: (_) => setState(() => _category = cat),
              );
            },
          ),
        ),
        const SizedBox(height: 4),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Destacados',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${items.length} productos',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),

        Expanded(
          child: CustomScrollView(
            slivers: [
              if (items.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.search_off,
                            size: 48, color: Colors.white38),
                        const SizedBox(height: 12),
                        const Text(
                          'No encontramos productos',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: _clearAll,
                          child: const Text('Limpiar búsqueda y filtros'),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ProductCard(
                        product: items[index],
                        onAdd: () => widget.onAdd(items[index]),
                      ),
                      childCount: items.length,
                    ),
                  ),
                ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: _InsightBanner(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChipGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  const _ChipGroup({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in options)
              ChoiceChip(
                label: Text(option),
                selected: selected == option,
                selectedColor: AppColors.cyan,
                checkmarkColor: Colors.black,
                labelStyle: TextStyle(
                  color: selected == option ? Colors.black : Colors.white,
                ),
                onSelected: (_) => onSelected(option),
              ),
          ],
        ),
      ],
    );
  }
}

// Header: banner horizontal del catálogo.
// Si la imagen falla, muestra un respaldo con el logo y el eslogan.
class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/header_cwe.png',
          width: double.infinity,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: double.infinity,
            height: 110,
            color: AppColors.surface,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CweLogo(fontSize: 34),
                Text(
                  'Conecta con la tierra',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        const Positioned(top: 10, right: 12, child: _ColombiaFlag()),
      ],
    );
  }
}

// Banderita de Colombia (esquina superior).
class _ColombiaFlag extends StatelessWidget {
  const _ColombiaFlag();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: SizedBox(
        width: 22,
        height: 15,
        child: Column(
          children: [
            Expanded(flex: 2, child: Container(color: AppColors.flagYellow)),
            Expanded(child: Container(color: AppColors.flagBlue)),
            Expanded(child: Container(color: AppColors.flagRed)),
          ],
        ),
      ),
    );
  }
}

// "Insight" (Figura 5).
class _InsightBanner extends StatelessWidget {
  const _InsightBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.blue.withValues(alpha: 0.25),
            AppColors.cyan.withValues(alpha: 0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.5)),
      ),
      child: const Row(
        children: [
          Icon(Icons.smart_toy_outlined, color: AppColors.cyan, size: 32),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Insight: Precios justos para agricultores, supermercados y clientes urbanos.',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
