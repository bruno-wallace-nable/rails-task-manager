class TasksController < ApplicationController
  # 1. Listar todas as tarefas
  def index
    @tasks = Task.all
  end

  # 2. Ver detalhes de uma tarefa específica
  def show
    @task = Task.find(params[:id])
  end

  # 3. Exibir o formulário de nova tarefa
  def new
    @task = Task.new
  end

  # 4. Salvar a nova tarefa no banco
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 5. Exibir o formulário de edição
  def edit
    @task = Task.find(params[:id])
  end

  # 6. Salvar as alterações da edição
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 7. Excluir uma tarefa
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, status: :see_other
  end

  private

  # Método de segurança: define quais campos o usuário pode preencher
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
