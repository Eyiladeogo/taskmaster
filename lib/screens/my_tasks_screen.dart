// lib/screens/my_tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:taskmaster/models/task.dart';
import 'package:taskmaster/screens/add_edit_task_screen.dart';
import 'package:taskmaster/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

enum TaskFilter { all, completed, pending }

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen>
    with SingleTickerProviderStateMixin {
  List<Task> _allTasks = [];
  List<Task> _filteredTasks = [];
  final LocalStorageService _localStorageService = LocalStorageService();
  late TabController _tabController;
  TaskFilter _currentFilter = TaskFilter.all;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _loadTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await _localStorageService.getTasks();
    setState(() {
      _allTasks = loadedTasks;
      _applyFilter();
    });
  }

  void _saveTasks() {
    _localStorageService.saveTasks(_allTasks);
  }

  void _applyFilter() {
    setState(() {
      switch (_currentFilter) {
        case TaskFilter.all:
          _filteredTasks = List.from(_allTasks);
          break;
        case TaskFilter.completed:
          _filteredTasks = _allTasks.where((task) => task.isCompleted).toList();
          break;
        case TaskFilter.pending:
          _filteredTasks = _allTasks
              .where((task) => !task.isCompleted)
              .toList();
          break;
      }
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentFilter = TaskFilter.values[_tabController.index];
        _applyFilter();
      });
    }
  }

  void _toggleTaskCompletion(String taskId, bool? isCompleted) {
    setState(() {
      final taskIndex = _allTasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        _allTasks[taskIndex].isCompleted = isCompleted ?? false;
        _saveTasks(); // Save changes to local storage
        _applyFilter(); // Re-apply filter to update the list
      }
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      _allTasks.removeWhere((task) => task.id == taskId);
      _saveTasks(); // Save changes to local storage
      _applyFilter(); // Re-apply filter to update the list
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Task deleted!')));
  }

  Future<void> _navigateToAddEditTask({Task? task}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditTaskScreen(task: task)),
    );

    if (result != null && result is Task) {
      setState(() {
        if (task == null) {
          // Add new task
          _allTasks.add(result);
        } else {
          // Edit existing task
          final index = _allTasks.indexWhere((t) => t.id == result.id);
          if (index != -1) {
            _allTasks[index] = result;
          }
        }
        _saveTasks(); // Save changes to local storage
        _applyFilter(); // Update filtered list
      });
    } else if (result == 'delete' && task != null) {
      // Handle delete action if it came from the AddEditTaskScreen
      _deleteTask(task.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt), // List icon as in the design
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(
            context,
          ).colorScheme.primary, // Active tab label color
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(
            context,
          ).colorScheme.primary, // Indicator line color
          indicatorSize:
              TabBarIndicatorSize.tab, // Makes indicator span the entire tab
          dividerColor: Colors.transparent, // Remove default divider
          tabs: const [
            Tab(text: 'All Tasks'),
            Tab(text: 'Completed'),
            Tab(text: 'Pending'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTaskList(), // All Tasks tab
          _buildTaskList(), // Completed tab (will be filtered by _applyFilter)
          _buildTaskList(), // Pending tab (will be filtered by _applyFilter)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditTask(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList() {
    if (_filteredTasks.isEmpty) {
      return Center(
        child: Text(
          'No ${_currentFilter == TaskFilter.all ? '' : _currentFilter.name} tasks found!',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _filteredTasks.length,
      itemBuilder: (context, index) {
        final task = _filteredTasks[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 1,
          child: InkWell(
            onTap: () => _navigateToAddEditTask(task: task),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? newValue) {
                      _toggleTaskCompletion(task.id, newValue);
                    },
                    // The color is set in the main theme's CheckboxThemeData
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task.isCompleted
                                ? Colors.grey[600]
                                : Colors.black87,
                          ),
                        ),
                        if (task.description != null &&
                            task.description!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            task.description!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (task.dueDate != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${task.dueDate!.day}/${task.dueDate!.month}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
