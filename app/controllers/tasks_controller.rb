class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = 'タスクが正常に作成されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクを作成できませんでした'
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = 'タスクは正常に変更されました'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクを更新できませんでした'
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'タスクを正常に削除できました'
        redirect_to tasks_url
    end
    
    private

    def task_params
    params.require(:task).permit(:content)
    end
end


