import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/constant/app_images.dart';
import 'package:kredipal/controller/allleads_controller.dart';
import 'package:kredipal/controller/login-controller.dart';
import 'package:kredipal/views/add_leads.dart';

import '../controller/dashboard_controller.dart';
import '../widgets/shimmer_widget.dart';
import 'emi_cal_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _EnhancedDashboardScreenState();
}

class _EnhancedDashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late PageController _motivationController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final AllLeadsController leadsController = Get.put(AllLeadsController());
  final AuthController authController = Get.find<AuthController>();
  final DashboardController dashboardController = Get.put(DashboardController());



  @override
  void initState() {
    super.initState();
    _motivationController = PageController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }



  @override
  void dispose() {
    _motivationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final horizontalPadding = isTablet ? 32.0 : 15.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Enhanced Sliver App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColor.appBarColor,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E3A8A),
                      Color(0xFF3B82F6),
                      Color(0xFF60A5FA),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background Pattern
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Header Content
                    Positioned(
                      top: 60,
                      left: horizontalPadding,
                      right: horizontalPadding,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildHeaderContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => _showNotifications(),
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 24),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints:
                              const BoxConstraints(minWidth: 1, minHeight: 1),
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Dashboard Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 12),
              child: Column(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildFilterButton('ALL', 'all', dashboardController),
                              _buildFilterButton('PL', 'personal_loan', dashboardController),
                              _buildFilterButton('BL', 'business_loan', dashboardController),
                              _buildFilterButton('HL', 'home_loan', dashboardController),
                              _buildFilterButton('CCL', 'creditcard_loan', dashboardController),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDateFilterDropdown(dashboardController),
                            Expanded(child: _buildDateRangeSection(dashboardController)),
                          ],
                        ),
                      )

                    ],
                  ),



                  // lead status Section
                  _buildEnhancedLeadStatusSection(isTablet),
                  // Loan Products Section
                  _buildEnhancedLoanProductsSection(isTablet),
                  // Quick Actions Section
                  _buildEnhancedQuickActionsSection(isTablet),

                  // Lead Status Section

                  // Recent Activities & Market Insights
                  if (isTablet)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildRecentActivities()),
                        const SizedBox(width: 16),
                        Expanded(child: _buildMarketInsights()),
                      ],
                    )
                  else ...[
                    _buildRecentActivities(),
                  ],

                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(AppImages.profileImg),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              Obx(() => Text(
                dashboardController.dashboardData.value.data?.user?.name ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String label, String leadTypeValue, DashboardController controller) {
    return Obx(() => GestureDetector(
      onTap: () {
        controller.selectedLeadType.value = leadTypeValue;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: controller.selectedLeadType.value == leadTypeValue
              ? Colors.blue
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: controller.selectedLeadType.value == leadTypeValue
                ? Colors.blue
                : Colors.grey.shade400,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: controller.selectedLeadType.value == leadTypeValue
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ));
  }

  Widget _buildDateRangeSection(DashboardController controller) {
    return Obx(() {
      if (controller.dateFilter.value != 'date_range') return SizedBox.shrink(); // hide if not selected

      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  controller.startDate.value = picked.toIso8601String().split('T')[0];
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => Text(
                  controller.startDate.value.isEmpty
                      ? "Start Date"
                      : controller.startDate.value,
                )),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  controller.endDate.value = picked.toIso8601String().split('T')[0];
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => Text(
                  controller.endDate.value.isEmpty
                      ? "End Date"
                      : controller.endDate.value,
                )),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildDateFilterDropdown(DashboardController controller) {
    return Obx(() => DropdownButton<String>(
      value: controller.dateFilter.value,
      items: [
        DropdownMenuItem(value: 'date_range', child: Text('Date Range')),
        DropdownMenuItem(value: 'this_year', child: Text('This Year')),
        // DropdownMenuItem(value: 'this_week', child: Text('This Week')),
        DropdownMenuItem(value: 'this_month', child: Text('This Month')),
      ],
      onChanged: (val) {
        if (val != null) controller.dateFilter.value = val;
      },
    ));
  }






  Widget _buildEnhancedLoanProductsSection(bool isTablet) {
    return Obx(() {

      if (dashboardController.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      final dashboardData = dashboardController.dashboardData.value.data;
      final personalLoanAmount = dashboardData?.leadTypeBreakdown?.personalLoan?.totalAmount ?? 0;
      final businessLoanAmount = dashboardData?.leadTypeBreakdown?.businessLoan?.totalAmount ?? 0;
      final homeLoanAmount = dashboardData?.leadTypeBreakdown?.homeLoan?.totalAmount ?? 0;
      final creditCardLoanAmount = dashboardData?.leadTypeBreakdown?.creditCard?.totalAmount ?? 0;

      final loanProducts = [
        {
          'title': 'Personal Loan',
          'subtitle': _formatCurrency(personalLoanAmount),
          'icon': Icons.person_outline_rounded,
          'color': const Color(0xFF3B82F6),
          'rate': '10.5% onwards',
          'features': ['No collateral', 'Instant approval'],
          'onTap': () => Get.to(() => AddLeadsPage(preselectedLeadType: 'personal_loan')),
        },
        {
          'title': 'Business Loan',
          'subtitle': _formatCurrency(businessLoanAmount),
          'icon': Icons.business_center_outlined,
          'color': const Color(0xFF10B981),
          'onTap': () => Get.to(() => AddLeadsPage(preselectedLeadType: 'business_loan')),
        },
        {
          'title': 'Home Loan',
          'subtitle': _formatCurrency(homeLoanAmount),
          'icon': Icons.home_outlined,
          'color': const Color(0xFFF59E0B),
          'onTap': () => Get.to(() => AddLeadsPage(preselectedLeadType: 'home_loan')),
        },
        {
          'title': 'Credit  Card',
          'subtitle': _formatCurrency(creditCardLoanAmount),
          'icon': Icons.credit_card_outlined,
          'color': const Color(0xFF8B5CF6),
          'onTap': () => Get.to(() => AddLeadsPage(preselectedLeadType: 'creditcard_loan')),
        },
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 4 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio: isTablet ? 0.9 : 1,
            ),
            itemCount: loanProducts.length,
            itemBuilder: (context, index) {
              final product = loanProducts[index];
              return _buildEnhancedLoanProductCard(product);
            },
          ),
        ],
      );
    });
  }

  Widget _buildEnhancedLoanProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
            onTap: product['onTap'],

          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: product['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        product['icon'],
                        color: product['color'],
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  product['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product['subtitle'],
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedQuickActionsSection(bool isTablet) {
    final quickActions = [
      {
        'title': 'EMI Calculator',
        'icon': Icons.calculate_outlined,
        'color': const Color(0xFF3B82F6),
        'onTap': () => Get.to(() => EmiCalculatorPage()),
      },
      {
        'title': 'Credit Card',
        'icon': Icons.credit_score_outlined,
        'color': const Color(0xFF10B981),
        'onTap': () => _showComingSoon('Credit Score Checker'),
      },
      {
        'title': 'Documents',
        'icon': Icons.description_outlined,
        'color': const Color(0xFFF59E0B),
        'onTap': () => _showComingSoon('Document Manager'),
      },
      {
        'title': 'Support',
        'icon': Icons.support_agent_outlined,
        'color': const Color(0xFF8B5CF6),
        'onTap': () => _showComingSoon('Customer Support'),
      },
      {
        'title': 'Loan Status',
        'icon': Icons.track_changes_outlined,
        'color': const Color(0xFFDC2626),
        'onTap': () => _showComingSoon('Loan Tracker'),
      },
      {
        'title': 'Reports',
        'icon': Icons.analytics_outlined,
        'color': const Color(0xFF059669),
        'onTap': () => _showComingSoon('Analytics Reports'),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 6 : 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: quickActions.length,
          itemBuilder: (context, index) {
            final action = quickActions[index];
            return _buildEnhancedQuickActionCard(action);
          },
        ),
      ],
    );
  }

  Widget _buildEnhancedQuickActionCard(Map<String, dynamic> action) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: action['onTap'],
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: action['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    action['icon'],
                    color: action['color'],
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  action['title'],
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedLeadStatusSection(bool isTablet) {
    return Obx(() {
      if (dashboardController.isLoading.value) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 4 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: isTablet ? 1.1 : 0.9,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return const LeadStatShimmer();
          },
        );
      }

      final aggregates = dashboardController.dashboardData.value.data?.aggregates;

      if (aggregates == null) {
        return const Center(child: Text('No data available'));
      }

      final leadStats = [
        {
          'title': 'Personal Leads',
          'count': aggregates.totalLeads?.count?.toString() ?? '0',
          'amount': dashboardController.formatCurrency(
              aggregates.totalLeads?.totalAmount?.toString() ?? '0'),
          'icon': Icons.assessment_outlined,
          'color': const Color(0xFF3B82F6),
          'percentage': 100.0,
          'trend': '+5.2',
        },
        {
          'title': 'Authorized Leads',
          'count': 1,
          'amount': dashboardController.formatCurrency(
              aggregates.totalLeads?.totalAmount?.toString() ?? '0'),
          'icon': Icons.assessment_outlined,
          'color': const Color(0xFF3B82F6),
          'percentage': 100.0,
          'trend': '+5.2',
        },
        {
          'title': 'Approved Leads',
          'count': aggregates.approvedLeads?.count?.toString() ?? '0',
          'amount': dashboardController.formatCurrency(
              aggregates.approvedLeads?.totalAmount?.toString() ?? '0'),
          'icon': Icons.check_circle_outline,
          'color': const Color(0xFF10B981),
          'percentage': 62.2,
          'trend': '+12.8%',
        },
        {
          'title': 'Disbursed Leads',
          'count': aggregates.disbursedLeads?.count?.toString() ?? '0',
          'amount': dashboardController.formatCurrency(
              aggregates.disbursedLeads?.totalAmount?.toString() ?? '0'),
          'icon': Icons.check_circle_outline,
          'color': const Color(0xFF10B981),
          'percentage': 30.5,
          'trend': '+4.3%',
        },
        {
          'title': 'Login Leads',
          'count': aggregates.pendingLeads?.count?.toString() ?? '0',
          'amount': dashboardController.formatCurrency(
              aggregates.pendingLeads?.totalAmount?.toString() ?? '0'),
          'icon': Icons.login_outlined,
          'color': const Color(0xFFF59E0B),
          'percentage': 17.8,
          'trend': '+3.1%',
        },
        {
          'title': 'Rejected Leads',
          'count': aggregates.rejectedLeads?.count?.toString() ?? '0',
          'amount': dashboardController.formatCurrency(
              aggregates.rejectedLeads?.totalAmount?.toString() ?? '0'),
          'icon': Icons.cancel,
          'color': const Color(0xFFFF0000), // Changed to red
          'percentage': 17.8,
          'trend': '+3.1%',
        },
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isTablet ? 1.1 : 0.8,
            ),
            itemCount: leadStats.length,
            itemBuilder: (context, index) {
              final stat = leadStats[index];
              return _buildEnhancedLeadStatCard(stat);
            },
          ),
        ],
      );    });
  }


  Widget _buildEnhancedLeadStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stat['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  stat['icon'],
                  color: stat['color'],
                  size: 20,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  stat['trend'],
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF059669),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            stat['count'].toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: stat['color'],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['title'],
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['amount'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          // Enhanced Progress bar
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Recent Activities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'Personal loan approved for ₹5L',
            '2 hours ago',
            Icons.check_circle_outline,
            const Color(0xFF10B981),
          ),
          _buildActivityItem(
            'New business loan application',
            '4 hours ago',
            Icons.business_center_outlined,
            const Color(0xFF3B82F6),
          ),
          _buildActivityItem(
            'Credit card disbursed',
            '1 day ago',
            Icons.credit_card_outlined,
            const Color(0xFF8B5CF6),
          ),
          _buildActivityItem(
            'Home loan documentation completed',
            '2 days ago',
            Icons.description_outlined,
            const Color(0xFFF59E0B),
          ),
          _buildActivityItem(
            'Customer meeting scheduled',
            '3 days ago',
            Icons.event_outlined,
            const Color(0xFFDC2626),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.insights_outlined,
                  color: Color(0xFF8B5CF6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Market Insights',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInsightItem(
            'Interest Rates',
            'Personal loans down by 0.5%',
            Icons.trending_down,
            const Color(0xFF10B981),
          ),
          _buildInsightItem(
            'Market Demand',
            'Home loans up by 12%',
            Icons.trending_up,
            const Color(0xFF3B82F6),
          ),
          _buildInsightItem(
            'Credit Score',
            'Average score improved',
            Icons.credit_score,
            const Color(0xFF8B5CF6),
          ),
          _buildInsightItem(
            'Approval Rate',
            '85% success rate this month',
            Icons.check_circle,
            const Color(0xFFF59E0B),
          ),
          _buildInsightItem(
            'New Products',
            'Green loans now available',
            Icons.eco,
            const Color(0xFF059669),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
      String title, String time, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
      String title, String description, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildNotificationItem(
                    'New loan application received',
                    'Personal loan for ₹3L from John Doe',
                    '5 min ago',
                    Icons.notification_important,
                    const Color(0xFF3B82F6),
                  ),
                  _buildNotificationItem(
                    'Loan approved successfully',
                    'Business loan for ₹10L has been approved',
                    '1 hour ago',
                    Icons.check_circle,
                    const Color(0xFF10B981),
                  ),
                  _buildNotificationItem(
                    'Document verification pending',
                    'Home loan application needs documents',
                    '2 hours ago',
                    Icons.warning,
                    const Color(0xFFF59E0B),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String description, String time,
      IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        backgroundColor: const Color(0xFF3B82F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  String _formatCurrency(dynamic amount) {
    if (amount == null) return '₹0';
    try {
      double value = amount is String ? double.parse(amount) : amount.toDouble();
      if (value >= 10000000) {
        return '₹${(value / 10000000).toStringAsFixed(1)}Cr';
      } else if (value >= 100000) {
        return '₹${(value / 100000).toStringAsFixed(1)}L';
      } else if (value >= 1000) {
        return '₹${(value / 1000).toStringAsFixed(1)}K';
      } else {
        return '₹${value.toStringAsFixed(0)}';
      }
    } catch (_) {
      return '₹0';
    }
  }

}
